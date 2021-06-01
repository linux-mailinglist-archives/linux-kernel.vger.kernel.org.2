Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A42397824
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 18:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbhFAQgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 12:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbhFAQgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:36:15 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9BBC061574;
        Tue,  1 Jun 2021 09:34:31 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id h3so8602237wmq.3;
        Tue, 01 Jun 2021 09:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=bvCCBlAI0cegQuZ44NSg9CufixTnatS00Nz8370cpqc=;
        b=B1Zqq99yrb4FADvGT1FhuXSVWaP6AcDmUNlcQi6xFjSUo47pJZMNWji4W1KBPUoaCp
         lvevw+NvhaHLcYKL14MSQlkCPvJNc+Z/x3yTNfkPg13IRPDM/G2fy+OGaDDV3pT53IYW
         l+0OJQBG+t4PJD+x4jV+cWvhhbG3L5X0GEEWWECmrz5hiXstma+b1sH4eaBBgXUvDqBU
         3MDBvVw9PSHegSv5kGIEvyvuSDQ0WpRpyqmzgesx8/c6KOgxVvD+AeWwWQ6hkRdm9fmw
         DGTY9V6XIayRNgjs+Vr9j3mMLYCNL8UXs+ynxpteHQtW6TFSWxiPKpO7v8LV0uQ1E6PV
         Ai0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=bvCCBlAI0cegQuZ44NSg9CufixTnatS00Nz8370cpqc=;
        b=VxsQ02CRiICehvJCCLPTLskh3oNjn8/UO13nXpBH+shJyakdHXm/maJWibqmNlxALk
         oIEo8+ty8/p59giJ4L/fS/yC3qK0VgTkr2G18YVRV/ofVRXRhabOOxVXad3thTqGuCOd
         1biZ60y8kY8qwMLnYJEKWBX/qm9lbdnl718njD8o9Kll8QiQifAYJOBvV3vco4w9669E
         66zNQpwcii4RB/mioARGmdwwSfxd/yiDK/uBRngLzvgKePvsmikDsc1vsttGQiSLyObE
         R4+LpvVJ0GCQn7f//4D36MbcsOzFqQ/jIepLxIevRbJNH5iMsNG41pAILvxK9dq59qbL
         FhHw==
X-Gm-Message-State: AOAM531UqjkSQX3g9bWDXe9vsDV1IOf0WRhkE9Fx+R2L60gkcvfiJ4v7
        GMXcWpX/fahxYysrxoJ67ECQx93KNds=
X-Google-Smtp-Source: ABdhPJy6vRXQIIKgw1cvPhmGkU2rDBerzDkGGWkN6tEAETe1C30BNvwsznkZWiue4b4OBsAb6prw4w==
X-Received: by 2002:a7b:cbc2:: with SMTP id n2mr27692896wmi.69.1622565270396;
        Tue, 01 Jun 2021 09:34:30 -0700 (PDT)
Received: from [89.139.227.208] (89-139-227-208.bb.netvision.net.il. [89.139.227.208])
        by smtp.gmail.com with ESMTPSA id n6sm7208wmq.34.2021.06.01.09.34.28
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 01 Jun 2021 09:34:29 -0700 (PDT)
Message-ID: <60B6615F.1050807@gmail.com>
Date:   Tue, 01 Jun 2021 19:33:35 +0300
From:   Eli Billauer <eli.billauer@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Colin King <colin.king@canonical.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] char: xillybus: Fix spelling mistake "overflew"
 -> "overflowed"
References: <20210601102201.8489-1-colin.king@canonical.com>
In-Reply-To: <20210601102201.8489-1-colin.king@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/21 13:22, Colin King wrote:
> There is a spelling mistake in a dev_err message. Fix it.
>
>    
This is actually a grammar mistake: Overflew is the past of overfly, not 
overflow.

I stand corrected nevertheless. Thanks.

    Eli

Acked-by: Eli Billauer <eli.billauer@gmail.com>
