Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2319236F723
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 10:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhD3IcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 04:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhD3IcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 04:32:04 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC51C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 01:31:16 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a4so69626530wrr.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 01:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I0ktwXj/LufSDPcWIwR3A5LuKeogVGJ5D0aKzv45ni0=;
        b=K3FRPCTIOIcVfiM0ikTVUZ3B7q7yS5+SWHMujMW3/BgCEhHutSOBoeb0898FV39FxT
         mqSxqwkOo1C5lJTz+zcuBI0f50DMWz20m/Ok9rQGuJdnWfZG4JgQz0qUIzaO2ablgg5W
         NkczboABhPeV3qoIDLElyeSpYNN7br7gA0QsoLWTMG/N0JoYz77cVWjHYb3izoDXLcMB
         RieL5ogADKcxmPQcouMikRV2Ga+BmTJgEggatDH1KAOFdkKHw5cu2F6DMfVIlBHhlW12
         d1nfBps3hwhCt5X4XAoNACsrIgUj/kNkeK4aNqtHxu3aYBt0AE2k3oMxd/xL3bZFYSmz
         lvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=I0ktwXj/LufSDPcWIwR3A5LuKeogVGJ5D0aKzv45ni0=;
        b=T4zMGV5rdW2Z73jpcVw0xGjpV46h84Tnp2wxAmiidwv1xEeLImhxbUSQPLuozl3tqg
         KmkfrdTJoSUnkdAZ5Fz34F3mLQxksZeeFdNp4AXMyYVKmGUaBkTK0qTfr8fvGmW9cUpV
         f4g3LOvc7s2BmMTKqCaXsbP/XI3uMFvOyI1bKWmjkklOLlKBMS+XP2arGmVA7Va+tADo
         AUr/NQGe+ZOxU7HvNag5nz8Fyg58OSiJMKfHTHIT8Iy776jHBggn17+SZ9BWEVpJVk5g
         z358KOOIh7Lcl83CmirWgEijcewNj/a1/th4pQUuQlwdUeVFyAqJCnLyv2b7bBQ/8BUe
         MGGQ==
X-Gm-Message-State: AOAM533hwGXeBk9qUIrV27Ap8uG0xNgF+5VSMLYTRhhHzc0cg/zm24Fk
        TJ9H8DGnIt0+QJxPcH+GtMrlTi7dZEL23hWY
X-Google-Smtp-Source: ABdhPJw9xLve5QbQXAL8IJ5O7GPw9kwlS+yguKzOeJ+oWdNivqpvwzKU4zA1UTZYbWOcU3Iijj4iTA==
X-Received: by 2002:adf:ff89:: with SMTP id j9mr5243182wrr.416.1619771474844;
        Fri, 30 Apr 2021 01:31:14 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:4a89:8c32:4adc:fc67? ([2a01:e0a:90c:e290:4a89:8c32:4adc:fc67])
        by smtp.gmail.com with ESMTPSA id s10sm1433195wrt.23.2021.04.30.01.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 01:31:14 -0700 (PDT)
Subject: Re: [PATCH] ASoC: meson: g12a-toacodec: add support for SM1 TOACODEC
To:     Jerome Brunet <jbrunet@baylibre.com>, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210429170147.3615883-1-narmstrong@baylibre.com>
 <1jo8dx9ec5.fsf@starbuckisacylon.baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <d2e9fc82-1483-e4d0-db10-6c11d9fdbba9@baylibre.com>
Date:   Fri, 30 Apr 2021 10:31:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1jo8dx9ec5.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2021 19:43, Jerome Brunet wrote:
> 
> On Thu 29 Apr 2021 at 19:01, Neil Armstrong <narmstrong@baylibre.com> wrote:
> 
> 
>>  
>> +static int sm1_toacodec_mux_put_enum(struct snd_kcontrol *kcontrol,
>> +				     struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct snd_soc_component *component =
>> +		snd_soc_dapm_kcontrol_component(kcontrol);
>> +	struct snd_soc_dapm_context *dapm =
>> +		snd_soc_dapm_kcontrol_dapm(kcontrol);
>> +	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
>> +	unsigned int mux, changed;
>> +
>> +	mux = snd_soc_enum_item_to_val(e, ucontrol->value.enumerated.item[0]);
>> +	changed = snd_soc_component_test_bits(component, e->reg,
>> +					      CTRL0_DAT_SEL_SM1,
>> +					      FIELD_PREP(CTRL0_DAT_SEL_SM1, mux));
>> +
>> +	if (!changed)
>> +		return 0;
>> +
>> +	/* Force disconnect of the mux while updating */
>> +	snd_soc_dapm_mux_update_power(dapm, kcontrol, 0, NULL, NULL);
>> +
>> +	snd_soc_component_update_bits(component, e->reg,
>> +				      CTRL0_DAT_SEL_SM1 |
>> +				      CTRL0_LRCLK_SEL_SM1 |
>> +				      CTRL0_BCLK_SEL_SM1,
>> +				      FIELD_PREP(CTRL0_DAT_SEL_SM1, mux) |
>> +				      FIELD_PREP(CTRL0_LRCLK_SEL_SM1, mux) |
>> +				      FIELD_PREP(CTRL0_BCLK_SEL_SM1, mux));
>> +
>> +	/*
>> +	 * FIXME:
>> +	 * On this soc, the glue gets the MCLK directly from the clock
>> +	 * controller instead of going the through the TDM interface.
>> +	 *
>> +	 * Here we assume interface A uses clock A, etc ... While it is
>> +	 * true for now, it could be different. Instead the glue should
>> +	 * find out the clock used by the interface and select the same
>> +	 * source. For that, we will need regmap backed clock mux which
>> +	 * is a work in progress
>> +	 */
>> +	snd_soc_component_update_bits(component, e->reg,
>> +				      CTRL0_MCLK_SEL,
>> +				      FIELD_PREP(CTRL0_MCLK_SEL, mux));
>> +
>> +	snd_soc_dapm_mux_update_power(dapm, kcontrol, mux, e, NULL);
>> +
>> +	return 0;
>> +}
> 
> Instead of duplicating this function, I'd prefer if you could use regmap fields
> 
> 

Sure, will do
