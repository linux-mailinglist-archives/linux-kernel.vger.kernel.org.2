Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A193EADBF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 01:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbhHLXpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 19:45:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50239 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229601AbhHLXpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 19:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628811886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rd3OV6Dvw8ckC2y3lCBsgXJ9t52P1EWnPLZIGT1HBu4=;
        b=QGl+sH/s7K8NbwD6+ZyP64h8ca69xCGZUiwqwxMkOe4u9p+KU5UYj3mDM7e0if0VNcZ18q
        K/bKrFQ8TIFka2NUXn7e/B0i2mcImgQTJX1b2Jyf0h4x7wyE+mSikWgM1eieydRHD6VgPC
        TmttKIjMIx+uP0fmrhbIZs6s/3tAknc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-ZaF8jtUaOK-Tku2-STNFjQ-1; Thu, 12 Aug 2021 19:44:45 -0400
X-MC-Unique: ZaF8jtUaOK-Tku2-STNFjQ-1
Received: by mail-qv1-f69.google.com with SMTP id t3-20020a0cf9830000b0290359840930bdso981512qvn.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 16:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rd3OV6Dvw8ckC2y3lCBsgXJ9t52P1EWnPLZIGT1HBu4=;
        b=YYoKOCp+LgnKgsEKvaDCxvJ1UbH4uDzOr176dfi6JWRpRzwGPjQyRRtSn5zahareFY
         gPFSSQc/RI73NSKHUvodF/r5ZeyOXdX/QMEZ45UQRuZW9QmaaHuQwIiuQxfbM31dVotI
         pCY+aooTmnAW2XlwqwqQFyqxIanJVRB6rAVJa+SvvSjnfyeUf8eC3+vqI2BwLKi50t+y
         N9dfII1Eo+IjclytOrlZov1eN4bISyFGSkTHCBj9ZtlSqU7EhH8MxgO+DEubJFghvJQF
         3KJAVZcpF3dqz/BQIwIg2zD8fQiVOEuYfJktokEosoqKF/yep9AzJnurlmA2J3EOxenl
         c1GA==
X-Gm-Message-State: AOAM533K2HWf9TbXhinQZ17oIbMHZzZ6i2+7AjADdfgZrCthvnV3Gd6H
        BYPbfka+OFGt5O7BFnaBOmQv2iRpIQB0IBagbDmwbpNRo68JOSBlUgk5ndjlEsbrtjKFoHGLpu0
        yE/iXkOI+bDLclS3Nn65JZg5r
X-Received: by 2002:a05:6214:29cb:: with SMTP id gh11mr6584277qvb.61.1628811884826;
        Thu, 12 Aug 2021 16:44:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtG0F13woSdCNsO/CYR7HlZ20+h7PTpQJDd38J7ov84KwjSzS4NEGUxdOjgIDcPQ5EpPxMAg==
X-Received: by 2002:a05:6214:29cb:: with SMTP id gh11mr6584258qvb.61.1628811884614;
        Thu, 12 Aug 2021 16:44:44 -0700 (PDT)
Received: from treble ([68.74.140.199])
        by smtp.gmail.com with ESMTPSA id i10sm2286766qkl.51.2021.08.12.16.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 16:44:44 -0700 (PDT)
Date:   Thu, 12 Aug 2021 16:44:40 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Ramakrishna Saripalli <rsaripal@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Jonathan Corbet <corbet@lwn.net>, bsd@redhat.com
Subject: Re: [v6 1/1] x86/bugs: Implement mitigation for Predictive Store
 Forwarding
Message-ID: <20210812234440.tcssf2iqs435bgdo@treble>
References: <20210517220059.6452-1-rsaripal@amd.com>
 <20210517220059.6452-2-rsaripal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210517220059.6452-2-rsaripal@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 05:00:58PM -0500, Ramakrishna Saripalli wrote:
> From: Ramakrishna Saripalli <rk.saripalli@amd.com>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 04545725f187..a5f694dccb24 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3940,6 +3940,11 @@
>  			Format: {"off"}
>  			Disable Hardware Transactional Memory
>  
> +	predictive_store_fwd_disable=	[X86] This option controls PSF.
> +			off - Turns on PSF.
> +			on  - Turns off PSF.
> +			default : off.
> +

This needs a lot more text.

> +static const char * const psf_strings[] = {
> +	[PREDICTIVE_STORE_FORWARD_NONE]		= "Vulnerable",
> +	[PREDICTIVE_STORE_FORWARD_DISABLE]	= "Mitigation: Predictive Store Forward disabled",

This defaults to "Vulnerable", which is problematic for at least a few
reasons.

1) I'm fairly sure this would be the first mitigation designed to
   default to "Vulnerable".  Aside from whether that's a good idea, many
   users will be alarmed to see "Vulnerable" in sysfs.

2) If the system has the default per-process SSB mitigation
   (prctl/seccomp) then PSF will be automatically mitigated in the same
   way.  In that case "Vulnerable" isn't an accurate description.  (More
   on that below.)

> +static const struct {
> +	const char *option;
> +	enum psf_mitigation_cmd cmd;
> +} psf_mitigation_options[]  __initconst = {
> +	{ "on",		PREDICTIVE_STORE_FORWARD_CMD_ON },      /* Disable Speculative Store Bypass */
> +	{ "off",	PREDICTIVE_STORE_FORWARD_CMD_NONE },    /* Don't touch Speculative Store Bypass */

Copy/paste error in the comments: "Speculative Store Bypass" -> "Predictive Store Forwarding"

I'd also recommend an "auto" option:

	{ "auto",	PREDICTIVE_STORE_FORWARD_CMD_AUTO },    /* Platform decides */

which would be the default.  For now it would function the same as
"off", but would give room for tweaking defaults later.

> +static enum psf_mitigation __init __psf_select_mitigation(void)
> +{
> +	enum psf_mitigation mode = PREDICTIVE_STORE_FORWARD_NONE;
> +	enum psf_mitigation_cmd cmd;
> +
> +	if (!boot_cpu_has(X86_FEATURE_PSFD))
> +		return mode;
> +
> +	cmd = psf_parse_cmdline();
> +
> +	switch (cmd) {
> +	case PREDICTIVE_STORE_FORWARD_CMD_ON:
> +		mode = PREDICTIVE_STORE_FORWARD_DISABLE;
> +		break;
> +	default:
> +		mode = PREDICTIVE_STORE_FORWARD_NONE;
> +		break;
> +	}
> +
> +	x86_spec_ctrl_mask |= SPEC_CTRL_PSFD;

A comment would help for this last line.  I assume it's virt-related.

> +
> +	if (ssb_mode == SPEC_STORE_BYPASS_DISABLE)
> +		mode = PREDICTIVE_STORE_FORWARD_DISABLE;
> +
> +	if (mode == PREDICTIVE_STORE_FORWARD_DISABLE) {
> +		setup_force_cpu_cap(X86_FEATURE_PSFD);
> +		x86_spec_ctrl_base |= SPEC_CTRL_PSFD;
> +		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
> +	}

The PSF mitigation is (to some extent) dependent on the SSB mitigation,
since turning off SSB implicitly turns off PSF.  That should be
reflected properly in sysfs for the prctl/seccomp cases.  Here I'd
propose adding something like:

	} else if (ssb_mode == SPEC_STORE_BYPASS_PRCTL) {
		mode = PREDICTIVE_STORE_FORWARD_SSB_PRCTL;
	} else if (ssb_mode == SPEC_STORE_BYPASS_SECCOMP) {
		mode = PREDICTIVE_STORE_FORWARD_SSB_SECCOMP;
	}

And of course you'd need additional strings for those:

	[PREDICTIVE_STORE_FORWARD_SSB_PRCTL]	= "Mitigation: Predictive Store Forward disabled via SSB prctl",
	[PREDICTIVE_STORE_FORWARD_SSB_SECCOMP]	= "Mitigation: Predictive Store Forward disabled via SSB seccomp",

-- 
Josh

