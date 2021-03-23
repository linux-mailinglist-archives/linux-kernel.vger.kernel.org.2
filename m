Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2931345A8B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhCWJOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhCWJOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:14:16 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312BAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:14:16 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c4so13595065qkg.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=yKamrg4WQ+8FkyynMWBliZ0t9JpsQat8oBO83DGW1QQ=;
        b=k15rQQYFTnRWn6UkVkfxPOjIFEe2JNn89l2ipW6jz1vPKm1gH0MDxAUp4C/nuJc1y4
         tyWhu1SvPXNHdMdMTukSPNrOhQKZLkseHbidtLwUqnjxDLieaj4iqexwesLvbPbESDvW
         RTZKBQxIzZIshmKqsw1t6BRCDjc5kANvrRX13FX5eBNZ2i12u50LKPa5T5bkyFzW5sLm
         xedVrbyWvwC5dZCk5pX7XdIo6ZX+r77F/cC496THBXcN7oFR5axZ512/ZgthJs9kPXen
         5cgakFG+Qjhs7hCKhgL8jgfEwcudMRLtMFFsTSukOpbNlSdq4kBNMeIG/oooMhGt9dgC
         14Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=yKamrg4WQ+8FkyynMWBliZ0t9JpsQat8oBO83DGW1QQ=;
        b=NsIczTxZRNVlyjb8wK6ORMEJ5eFFFmJRiMYDnybxXEwDK+Xm2cHuhxeaJpm0hQEWPw
         S6ej0GWG1I2jp1l6oz0Yh1h8bJZCLygqPMRXh+lYvhGdUdxuuqMHJ9KUiokJ5qAjq2a6
         1mZa86APRyjj69/lLMUBqmVgh14EmWKlfKoTQlOdrPHCYUbiDSTi1A+scjuHp0iLvZBu
         4ho/RDTz6ubRJz2H0BrRE69e0AVCVcbCBZ1oWZFjtitBKSQOjxoc/vM1rgcQAO3Ze3rA
         m/P+XUQQ6y9m3FfSJViMb9dTeNgxVChwGjFgLRRgA3nnlXt1BUa/uLx/jm3zRIpkSBRA
         btcA==
X-Gm-Message-State: AOAM530QETekdiPHcLSYFDo4VGcy5un6bfmJQfRWPeaNvh60dbKlX4h6
        6JCxLoDdvJ9/z1JB47TxdVU=
X-Google-Smtp-Source: ABdhPJyh+0q5eJDWd+9DOmDi7kVHzpO0V0QZjUYLIszZuhys5Tq3g2ATH+OsE+oQNX+ksfTyjUENvw==
X-Received: by 2002:a37:a643:: with SMTP id p64mr4178667qke.276.1616490855481;
        Tue, 23 Mar 2021 02:14:15 -0700 (PDT)
Received: from ArchLinux ([143.244.44.229])
        by smtp.gmail.com with ESMTPSA id z5sm12793861qkz.2.2021.03.23.02.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 02:14:13 -0700 (PDT)
Date:   Tue, 23 Mar 2021 14:43:58 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, imre.deak@intel.com,
        ville.syrjala@linux.intel.com, lucas.demarchi@intel.com,
        matthew.d.roper@intel.com,
        tejaskumarx.surendrakumar.upadhyay@intel.com,
        aditya.swarup@intel.com, anusha.srivatsa@intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] drm/i915: A typo fix
Message-ID: <YFmxVmcW/hIzsP4o@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, imre.deak@intel.com,
        ville.syrjala@linux.intel.com, lucas.demarchi@intel.com,
        matthew.d.roper@intel.com,
        tejaskumarx.surendrakumar.upadhyay@intel.com,
        aditya.swarup@intel.com, anusha.srivatsa@intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
References: <20210323011607.182803-1-unixbhaskar@gmail.com>
 <87blba5jzo.fsf@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ssc5NCDR3r865LSQ"
Content-Disposition: inline
In-Reply-To: <87blba5jzo.fsf@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ssc5NCDR3r865LSQ
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 10:53 Tue 23 Mar 2021, Jani Nikula wrote:
>On Tue, 23 Mar 2021, Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
>> s/nothign/nothing/
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>
>You've sent the same patch before? I've already pushed it.
>
Apologies and thanks.

>BR,
>Jani.
>
>> ---
>>  drivers/gpu/drm/i915/display/intel_dpll_mgr.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
>> index f6ad257a260e..14d784a6fae5 100644
>> --- a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
>> +++ b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
>> @@ -4185,7 +4185,7 @@ static void icl_pll_disable(struct drm_i915_private *dev_priv,
>>  	/*
>>  	 * DVFS pre sequence would be here, but in our driver the cdclk code
>>  	 * paths should already be setting the appropriate voltage, hence we do
>> -	 * nothign here.
>> +	 * nothing here.
>>  	 */
>>
>>  	val = intel_de_read(dev_priv, enable_reg);
>> --
>> 2.31.0
>>
>
>--
>Jani Nikula, Intel Open Source Graphics Center

--ssc5NCDR3r865LSQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBZsVYACgkQsjqdtxFL
KRUJpggAiFamaV0R4z6RkkkOUE2bYAPm7eweNYgy2jWuLdI61fbw7FH7AmbBWH+a
kNgXlnPT6uSmy2jiu9uO3GVguYcxe25APtYd3VVNyRfiCONj1KvD1RNHFR3dG8aY
cai0XiI0dFA283DCP0LRMdTzHPIPwEfXW47CVbk5tfMINQV70VZKjDPnAxsoa5ch
gvHo8wo/ZQAb9K+2VeaoTaf2CF6hjf7U/UCV8WI9acO4+AJ6kM79ZchZlLT75q/w
5gtSUMK704FFFnYWNbsoMJiKXUHqs+2NuqQpTuyU/Z64pwppKJTTDvbJV3RJkYM3
0Vjb8Zewp05xO/bBwkAzecMr5u8JLw==
=WIVI
-----END PGP SIGNATURE-----

--ssc5NCDR3r865LSQ--
