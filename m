Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE483171D7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 22:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhBJVB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 16:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbhBJVBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 16:01:24 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BCAC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 13:00:43 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id a16so4527177wmm.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 13:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rZp7A+v4WBoQUiE0OhhhKKw56QCYcEoeSnDvzhpwo2M=;
        b=JDVIaflUJw9bBTdq3ctIHkYy8SkkxhtSJgQQP9bW7tduZv6mCoJHnNnGYEH/Or393r
         GJEjkYBy9wSzZXPv+zNXdE1gnpjVLsTxR/jTjyvRFEqm61I4Nfbw4KaUJ67SjVQgWjkv
         wAzvfs3J48W8ZHKVaMg1fV265PDLE5qrRl7bJ3nA5NrUVIRyXHR6wXBR13zmuCcu/vf5
         FY7u0zLTqxZ59jrJyciU9ZIHLWt2RRNgUaDwG8F3w/o+DJgOnNUk0MKaaHeqZglJoP/h
         7qt/ARv3ydu7fCiPiEt9GMKXdun8NyBjcEbsa72qQlAX/P7laTHCV8SXHMVymQ9UFEd4
         ehyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rZp7A+v4WBoQUiE0OhhhKKw56QCYcEoeSnDvzhpwo2M=;
        b=OSJlgPUAxC6xNFbGdxEYejn1S5BTRw+2VSO3vkJ0BdMh7VRSOjMxYk2HUS+GVuZhov
         IqyWJlWCVbHznKBfU5faZJIb7KWr2bZ2H+amCmxjShSHomKhh2vlbOFoItlja7JxAfRO
         0PRjEsTPyWPr5gad6cS579FaCSmqMt0z2oRiLKsEqZtg3vJVB+DN7RkFwc39kDo7OqRO
         W9Kc4ZJK9x9DPAAKFUPdY45hH1PC1DzD49WCCNHoGYVmAORHyBq4E10Tn/+FFvxb/Hj7
         yg347RqMwDJDX4/X7GbepJnbEmOafG8U9wIwr+wF5AIpAwgOIBSmU1BAQy80WKXdod2t
         pEMw==
X-Gm-Message-State: AOAM531w2jO3CBlTfB2ggCEnFcbkFVDcpkd/eiRAKRX70+U+s13lcga6
        G2Xmfu8U91qhSiJIS68si+tgDc9I78oFXA==
X-Google-Smtp-Source: ABdhPJxyJid9SF3FUbzMJFgxrftMe8ZG6eNhOB+9JksMFmVt31UxXtc0O162hXH0PMYeedtTDSIKyQ==
X-Received: by 2002:a7b:c5c1:: with SMTP id n1mr870556wmk.163.1612990837207;
        Wed, 10 Feb 2021 13:00:37 -0800 (PST)
Received: from kernelvm (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id z63sm4708558wme.8.2021.02.10.13.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 13:00:36 -0800 (PST)
Date:   Wed, 10 Feb 2021 21:00:34 +0000
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        luk@wybcz.pl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: cleanup macros within
 include/rtw_debug.h
Message-ID: <20210210210034.GA1919@kernelvm>
References: <20210210170003.100880-1-phil@philpotter.co.uk>
 <20210210184027.GZ2696@kadam>
 <20210210185544.GA1786@kernelvm>
 <20210210201849.GA2696@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210201849.GA2696@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > So I'm in the process of stripping out _dbgdump entirely as per Greg
> > K-H's suggestion - am I to understand raw printk is frowned upon though,
> > even with the correct KERN_x level specified?
> 
> Yes.  Ideally in drivers everything would use dev_dbg() and dev_err() or
> whatever.  But it's perhaps tricky to convert everything in a single
> patch so changing _dbgdump() to "#define pr_debug" as an intermediate
> step is probably fine.
> 
> Look at how people do pr_fmt():
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> 
> You could do a patch that does a mass replacement of DBG_871X with
> pr_debug().  Again, I haven't really looked at this code so you'll have
> to double check and consider what is the best way to break up the
> patches.
> 

That sounds great, I'll take a look, thanks.

> > One query I have is that individual patches I'm working on for this file are
> > generating an awful lot of checkpatch warnings themselves due to the
> > nature of the existing violations on the relevant lines. Is it
> > considered acceptable for me to still submit these, providing I do so in
> > a series which cleans up the other violations in separate patches?
> 
> It's tricky to know how to break up patches.  Probably the simplest
> advice is to only clean up a single type of checkpatch warning at a
> time.  But fix all the instances of that warning in a file.  Don't
> change anything else even if it is tempting.  Do that in the next patch.
> 
> The actuall rules are slightly more complicated and nuanced than that,
> but if you just fix one type at a time then that's okay.
> 
> One thing is that your patches should not introduce new checkpatch
> warnings.  So if you have two statements in an if statement and you
> delete one, then that means you have to delete he curly braces as well.
> 
> regards,
> dan carpenter
> 

Thanks again for the feedback. I will work on something over the next
few days.

Regards,
Phil
