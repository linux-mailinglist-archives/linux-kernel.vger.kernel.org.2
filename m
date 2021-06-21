Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB5B3AE9E4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 15:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFUNTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 09:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhFUNTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 09:19:33 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C795C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 06:17:18 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id c84so10465811wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 06:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wdw3Xub1vfifwdphbEo9GcuHgqK1JATecHa5k7b/FLo=;
        b=iCF4WX4ehsc4ylLVQWpFtiAxcb+TgsB72cfmMkZkivtGsJ8D8zbJwFajxsvIZV053o
         polIS3DQkewWeSWonQS306Ym1TNW4dkvz7RKh2+3GsMiGOcSgxPTLkxZROH4xg/qBuom
         dwl/aAe2IW6BRYD7X9fXNpiWuiEhJokEKF6QytXZm7/hhKypDXkoMtR84IHZGW6+iNnq
         M1NQiZQLw6eoYnkp30f8CoN6DgEdpTJ8usM1jeBsXLfp7HALqrZZEMVj29M9X3QlOzmC
         VUNg5LUmP6A/+6eZfo4BDlDF5ow5/elXMLeJQL3UgTGkZlnGT5v6f2XMpVnUeAmNH9ou
         llUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Wdw3Xub1vfifwdphbEo9GcuHgqK1JATecHa5k7b/FLo=;
        b=iQGIcyEVtzp2FNKjNMN1WrtFBFZFKPM04uMVZI5iPlOQL2EoWbxS7yFVuruVhaCs3b
         m1CSRiQlxAxT0xFd0fTZaZmwhI7ncvWctNZ+5mVHnE0e+7Fdxq2gG1/Gd/aliikP3ZHs
         DXcnoGFlNlpooSKDHhJ8iM/6WPJucR4fR1Sr5F+ftUy6q6C3P10uiUkxMFB8PVIM56rF
         qx5ncu1ZKkm+CxIHT58ksKd5c26Ub+tVg3yH24YhqXUvzTqGLortdIT+57cT0Rtc9HvI
         WA+7wEFg5Usot/3z+TpS7ePpvlPc3CRTOOY2EJSEn/D3vKEcWCylbIEQC2Qk+soLO4xx
         xhQA==
X-Gm-Message-State: AOAM533hqpOyPq/mb17zvyQ9XiptYLPO8qLf1HG2XVOKvsVqCrE7vdSf
        hUTu4ZY6UHmIfW8Bq1R/cgpVv4l6cEQ=
X-Google-Smtp-Source: ABdhPJyADL1f3yx8iBXXmJRLez6f86SlywPf6zra1TpeQmKNcKUFnxD0hrptRunEcoGdk/Tp1NTGVg==
X-Received: by 2002:a05:600c:190a:: with SMTP id j10mr5323233wmq.44.1624281437191;
        Mon, 21 Jun 2021 06:17:17 -0700 (PDT)
Received: from gmail.com (0526E2ED.unconfigured.pool.telekom.hu. [5.38.226.237])
        by smtp.gmail.com with ESMTPSA id t9sm16799956wmq.14.2021.06.21.06.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 06:17:16 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 21 Jun 2021 15:17:14 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     jpoimboe@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, joro@8bytes.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, x86@kernel.org,
        mbenes@suse.com
Subject: Re: [RFC][PATCH 00/18] objtool/x86: noinstr vs PARAVIRT
Message-ID: <YNCRWrhMiZ7P2SRv@gmail.com>
References: <20210621111233.344964031@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621111233.344964031@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> Hi!
> 
> Per long standing request from Thomas, this here mostly sorts the whole noinstr
> validation vs PARAVIRT.
> 
> It isn't exactly pretty or robust, but it does work.
> 
> So far only tested on x86_64-defconfig+kvm_guest.config+xen.config. I did a
> quick allyesconfig build, but still saw some funnies with that, will poke at them.

Didn't see anything weird in these patches.

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
