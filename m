Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE27456D28
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 11:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbhKSKYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 05:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbhKSKYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 05:24:22 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7DFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 02:21:20 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id l22so40934057lfg.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 02:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=klHkE6Kbgb/qGHRJDqBaYHPicGUlppfEJO5m9rGf3bM=;
        b=uvNn/ev/ygGp+ON/V5VDr/ud2AtPL56SCAtgRHOJdTwnu2TPWLmJJCmHXQuBxB8bsK
         HgefYyrXKFQjmZo5HkvTGNic+gvsuxL3/xrdc+tyq7PFcC8f7/R+913MjEVosUYo7dB6
         u8WDcXzUw+UfCqRoshBIGndaRo39tEDqaWjQEqRlKZ3dByK7CQTOSTc63Secccx8KnDo
         59e1GaS0kDQE95CmWj3ax/ZBwhYPWiSh/HRiVecoBUuF8/zSCoAlYpt3PpXSRbvjGlLv
         eJe6atoe5GMurjfW7jWv6BH0l4YunorcSYZx7p5uEMoC2Qzj40bldlZqlssBX61lDhmF
         7kbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=klHkE6Kbgb/qGHRJDqBaYHPicGUlppfEJO5m9rGf3bM=;
        b=reyjDMZioymvir3KaimcX4Hq/lFDrrISZ8YY5LkKvNW0X1FEJJ0aNBvDO0d4/p8YmX
         AYl/UrZlDReGnK445kcXteQ1D44FyhadtvbPhTz+XYHHbJO+OzM18bx7Igqm9ezeDcaR
         4uYPDwutkzuYHm1HhfFnKIUWzeldhO2V05XcSsOZDoRK95J+O05mKH22W8Pye5Uq9KZu
         1kpNRdAFTk/QWbJzBnj8d2WbBO8ZXf17ljmOzaq2mXeAiq2OE/pidLqgkC+f9+eDeNbA
         KXAU7hFQ9CKWUhVoiuUzrQmGL8iBLDc4lARGSIjxb1MpGPGgZQzL7+t/8PvWybcRdWNt
         Ponw==
X-Gm-Message-State: AOAM531ToNzOH7Mw1fcFIQ1/ETFB3FEjqfnJjQB29tcBB8gBYP8yFN9+
        0wzXXLS71cjvz7Vi4yzhiLsc/g==
X-Google-Smtp-Source: ABdhPJy8gkLSVRTbk018/GoeARiRCokFjO17ew00QRBKEkNYbJ6hPSGHFXpg8XQTKtjD+uMqjyvqjw==
X-Received: by 2002:a2e:9903:: with SMTP id v3mr23904464lji.143.1637317278794;
        Fri, 19 Nov 2021 02:21:18 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z23sm247709ljk.136.2021.11.19.02.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 02:21:18 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id C0680103304; Fri, 19 Nov 2021 13:21:23 +0300 (+03)
Date:   Fri, 19 Nov 2021 13:21:23 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Juergen Gross <jgross@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>
Subject: Re: [PATCH] x86/paravirt: Fix build PARAVIRT_XXL=y without XEN_PV
Message-ID: <20211119102123.52pkdqgdqdvqefib@box.shutemov.name>
References: <20211117181439.4368-1-kirill.shutemov@linux.intel.com>
 <75452cf8-6250-95c2-1092-bae4d151f69e@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75452cf8-6250-95c2-1092-bae4d151f69e@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 07:23:51AM +0100, Juergen Gross wrote:
> On 17.11.21 19:14, Kirill A. Shutemov wrote:
> > TDX is going to use CONFIG_PARAVIRT_XXL, but kernel fails to compile if
> > XEN_PV is not enabled:
> > 
> > 	ld.lld: error: undefined symbol: xen_iret
> > 
> > It happens because INTERRUPT_RETURN defined to use xen_iret if
> > CONFIG_PARAVIRT_XXL enabled regardless of CONFIG_XEN_PV.
> > 
> > The issue is not visible in the current kernel because CONFIG_XEN_PV is
> > the only user of CONFIG_PARAVIRT_XXL and there's no way to enable them
> > separately.
> > 
> > Rework code to define INTERRUPT_RETURN based on CONFIG_XEN_PV, not
> > CONFIG_PARAVIRT_XXL.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Cc: Juergen Gross <jgross@suse.com>
> > Cc: Deep Shah <sdeep@vmware.com>
> > Cc: "VMware, Inc." <pv-drivers@vmware.com>
> 
> I agree with the patch, so:
> 
> Reviewed-by: Juergen Gross <jgross@suse.com>
> 
> Nevertheless I believe that TDX should not switch to use PARAVIRT_XXL.

Do I need to resend without TDX mention?

-- 
 Kirill A. Shutemov
