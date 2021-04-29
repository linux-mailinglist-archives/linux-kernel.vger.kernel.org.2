Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1337C36EF10
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 19:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240998AbhD2Rn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 13:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbhD2Rn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 13:43:57 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D52BC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 10:43:09 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id gx5so9044376ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 10:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=BRjhSBhHMw0cfh8McFGX3T1RGcT74vqYpGonK7mWYDI=;
        b=Kiq0l4riPAKiNrT7WJO38D0K2S1WMBBF2WDDoJYhcaFGNwXSu6bwya5fgqLoocpIPD
         OsdN/9XBiFLxC8xL4EdVJp+Xrvc9Wti1b8t1aPWQWuH1msE9XiPLnG/NE6OpkTQBsD5j
         pMMWNN3OJOJmB00zYIioJfkMihUkBabKT6p+oP0ATQUZ/sr1nbp0An9yeszAe4Y7mtZR
         BBqr9c8jl3OFLieEYDvoVUb0gahKb766iwSp0mvFTeYJo/ddUY00IBk3YfgT8BzDTwHQ
         cy7OEJwYCiCOnfZ+8OL2Eyv/gnCBDDnkgiX8B4JZvXl4H05uO+OQCquxXTaGQ0bHM6/a
         RKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=BRjhSBhHMw0cfh8McFGX3T1RGcT74vqYpGonK7mWYDI=;
        b=pv/qBazzfTpax/gMFNwM0IL9Kv8vH1P9G12TyxKp6xicOgvqcXRK9EloS9dqLAwBCc
         gzgT9bidhaawqrQhNaaTpcgYyfOrmTFn1Us7ivnnHerefDyUSrSXvwXF545Fvi6IUDa/
         U2zPYU6bDxOWG3fuK8RuIRsJGlCoiwS96oiwjp+qbnXyZRFTcWfItZ/nOIzjuPKHShPf
         ABHVi7n0AXiqjSQXa366IhaTsjCfbbvclGEwf2I1bOnegPA87IMbvVrb4UCVO2MoRo+a
         2stOXieiIfZa2ZCEvT+Fam640jYv6S40Zl2KUTM9fi4IA+gH+uSzdyek/HAmoxwwFbXz
         ymxw==
X-Gm-Message-State: AOAM533E3Ti4jzx6Wh/5jwQ9UxfvLzIpcfnGTrYXBh5Xu/5KSuQ3ynDX
        JW9u83TPImFgY35kQOctacCkkw==
X-Google-Smtp-Source: ABdhPJx1ZgmV97KuEwi9+JdPZAVO4jUb2ew4j//svpTXFE+Kseaa2P/yi/AHDBRde4cmoKrvVSnHGw==
X-Received: by 2002:a17:906:6544:: with SMTP id u4mr1065841ejn.455.1619718187971;
        Thu, 29 Apr 2021 10:43:07 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id d5sm2877135edt.49.2021.04.29.10.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 10:43:07 -0700 (PDT)
References: <20210429170147.3615883-1-narmstrong@baylibre.com>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: meson: g12a-toacodec: add support for SM1 TOACODEC
In-reply-to: <20210429170147.3615883-1-narmstrong@baylibre.com>
Message-ID: <1jo8dx9ec5.fsf@starbuckisacylon.baylibre.com>
Date:   Thu, 29 Apr 2021 19:43:06 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 29 Apr 2021 at 19:01, Neil Armstrong <narmstrong@baylibre.com> wrote:


>  
> +static int sm1_toacodec_mux_put_enum(struct snd_kcontrol *kcontrol,
> +				     struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component =
> +		snd_soc_dapm_kcontrol_component(kcontrol);
> +	struct snd_soc_dapm_context *dapm =
> +		snd_soc_dapm_kcontrol_dapm(kcontrol);
> +	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
> +	unsigned int mux, changed;
> +
> +	mux = snd_soc_enum_item_to_val(e, ucontrol->value.enumerated.item[0]);
> +	changed = snd_soc_component_test_bits(component, e->reg,
> +					      CTRL0_DAT_SEL_SM1,
> +					      FIELD_PREP(CTRL0_DAT_SEL_SM1, mux));
> +
> +	if (!changed)
> +		return 0;
> +
> +	/* Force disconnect of the mux while updating */
> +	snd_soc_dapm_mux_update_power(dapm, kcontrol, 0, NULL, NULL);
> +
> +	snd_soc_component_update_bits(component, e->reg,
> +				      CTRL0_DAT_SEL_SM1 |
> +				      CTRL0_LRCLK_SEL_SM1 |
> +				      CTRL0_BCLK_SEL_SM1,
> +				      FIELD_PREP(CTRL0_DAT_SEL_SM1, mux) |
> +				      FIELD_PREP(CTRL0_LRCLK_SEL_SM1, mux) |
> +				      FIELD_PREP(CTRL0_BCLK_SEL_SM1, mux));
> +
> +	/*
> +	 * FIXME:
> +	 * On this soc, the glue gets the MCLK directly from the clock
> +	 * controller instead of going the through the TDM interface.
> +	 *
> +	 * Here we assume interface A uses clock A, etc ... While it is
> +	 * true for now, it could be different. Instead the glue should
> +	 * find out the clock used by the interface and select the same
> +	 * source. For that, we will need regmap backed clock mux which
> +	 * is a work in progress
> +	 */
> +	snd_soc_component_update_bits(component, e->reg,
> +				      CTRL0_MCLK_SEL,
> +				      FIELD_PREP(CTRL0_MCLK_SEL, mux));
> +
> +	snd_soc_dapm_mux_update_power(dapm, kcontrol, mux, e, NULL);
> +
> +	return 0;
> +}

Instead of duplicating this function, I'd prefer if you could use regmap fields


