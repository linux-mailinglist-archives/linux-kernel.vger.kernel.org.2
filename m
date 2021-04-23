Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101ED3695EE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhDWPSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbhDWPSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:18:39 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AA2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 08:18:01 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id s5so41144804qkj.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 08:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kepstin.ca; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=TT/GtDW+dzXPPtJ2iwcN+nceLp9c+oAutwWNCDukYyg=;
        b=azsqOrerHPonKjkL3KRPNV07IBqcBLt/gw8Z9MYXp6y3fdmyWbrZfDfSM0TxTHXmev
         +ljyZUyTJ8OZGNp7zEjgCLXMMmZqOgd8mhN7W5Sem7lrhYK7Xj+3t4kHK+B/92CpPDGK
         pAhpHDr3LYXBCLkS41kDFrPEvLBsoYHNkXJ7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=TT/GtDW+dzXPPtJ2iwcN+nceLp9c+oAutwWNCDukYyg=;
        b=i+PHdaQttsuHsfevGxrt5Wvl8+rphifUFLuNI9KKf4csS6986ypR8V/2i7jv9OhU6V
         zuqrakOZ5ruP3Vhyu80xsrbZVGmPMFUaz/HX95pYFYurAJcDtUfYYSRsq+GPiU9ii8Sf
         aRXmkrc+Zq2wV020ve+d1P7VO5ziaCxak9N/b1u0YxTyyQVDsJ0oolX6uAVxs8U0G66f
         /NTRWEU3Uagu3MrVDKBoJUz7OIYlz07JKlgWHPwITqCSV9oR6eiwnyUVKGCqjvWJLcBo
         YoL4b2Pk4TWHBrPNTwb0MMO52zQ5VlxiPATfq12+smq67h3pPRQZ4HarxEu+QkZ6edeB
         Dc3w==
X-Gm-Message-State: AOAM532YBYlJRCAY39cILZH13grjkePCaHmhWe5o6lEGcT/msv/NBliv
        CaXC/YL/iamdXMvx8MdkykBjcp6zasvifJaxrOY=
X-Google-Smtp-Source: ABdhPJxyIpQYgKWWsTPkumpoKvftQ+cl9Dw4/xEq46VfygDPTc5cJQm1OUxc9HVQZn6OQYRBD2TLnA==
X-Received: by 2002:a37:8905:: with SMTP id l5mr4732784qkd.321.1619191080526;
        Fri, 23 Apr 2021 08:18:00 -0700 (PDT)
Received: from sasami.kepstin.ca (dhcp-108-168-125-232.cable.user.start.ca. [108.168.125.232])
        by smtp.gmail.com with ESMTPSA id o189sm4372567qkd.60.2021.04.23.08.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 08:17:59 -0700 (PDT)
Message-ID: <8fb9a5d2a46216c1ce3f63b621ff9d35c1f863a9.camel@kepstin.ca>
Subject: Re: [PATCH v2] tools/power turbostat: Fix RAPL summary collection
 on AMD processors
From:   Calvin Walton <calvin.walton@kepstin.ca>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Borislav Petkov <bp@suse.de>, Terry Bowman <terry.bowman@amd.com>,
        lenb@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, wei.huang2@amd.com, aros@gmx.com,
        rui.zhang@intel.com
Date:   Fri, 23 Apr 2021 11:17:56 -0400
In-Reply-To: <20210423142749.GA428460@chenyu-desktop>
References: <20210419195812.147710-1-terry.bowman@amd.com>
         <20210420020336.GA386151@chenyu-desktop> <20210420080701.GA2326@zn.tnic>
         <20210420131541.GA388877@chenyu-desktop>
         <4cbb1eff77de1e843912267ade4686cfa1acd610.camel@kepstin.ca>
         <20210420143754.GA390118@chenyu-desktop>
         <5cf35f3742d1181421d955174b1aa9434d042c96.camel@kepstin.ca>
         <20210423121607.GA426003@chenyu-desktop>
         <4080ac25f6c8ca4088a950eb9d63da641c020941.camel@kepstin.ca>
         <20210423142749.GA428460@chenyu-desktop>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-04-23 at 22:27 +0800, Chen Yu wrote:
> 
> This patch fixes this issue by converting the 'int' to 'unsigned int'
> accordingly.

NAK on this version of the patch. It needs to be off_t; see my
conversation with Boris elsewhere in this thread.

-- 
Calvin Walton <calvin.walton@kepstin.ca>

