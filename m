Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5713443117F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 09:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhJRHmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 03:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbhJRHmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 03:42:16 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDB5C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 00:40:03 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id g25so39449661wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 00:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VZmNs2GkzxhCB6JvBYnlodKD9/a6gtDFwX3G4j5wn7c=;
        b=oae7VeX5cuVbu+3yaIg3mCW2czfOxBXemxBlIV/GCmMSn7Aj2S36Cfp2Ej1UN5iZ5R
         n59i410Rso7mM0FYctJy9Qcza9G7OPMt45JKHUkjj6gBXOXrZRQAgeNQpdFKYAcQAEz7
         fH5nbg0HrhbN8+KrPKuJ7HuL25jtsyaBWXOj5r+0BQf3Gm4sPejcfTRk7JOD2IPARhbb
         PTY3ehD/1Hq9lRlRsZFej21R6JCPLFZaC7iMr2NOI1bvdhADA+KQof5JmF3BjK26vzl0
         nElkg51iqJ/x/8vso6C0mKXQNW3QhtimFsVQVB/gyiqi2UTiOrrGhPYGG3J+dq9snEA0
         mlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VZmNs2GkzxhCB6JvBYnlodKD9/a6gtDFwX3G4j5wn7c=;
        b=ctohRxr2A2VKzR2bYY14fAjaSTb77udgUqfjDIN+8pjn5dsxffFwrlqtpBxzPaSEtJ
         +beewkPz1v3OYFGFmhXoaejN10Dosz5J55IMzSZXwVgV9m/CPRRXVFPq59VHgXb0KyD2
         nRWhY0IgfAC2dXJCUXsIZfUjy1OElO3GpxQWBAJxLNhPktQ6tMhgHBOj8SY8Ts/S16CK
         9t5UqS7RZJdFzEk/6kq917Yd798921ed7E42YZy/yLOdoD4qTBf/l9Si2m7B0NFXJcKh
         6EkmAPNPdNos2jLPaVIsRdNTdI0SSS82dVzaRPiDKf4pDNRaeC/vAN0Y28AH/vy9oIZC
         NvQg==
X-Gm-Message-State: AOAM532C6HNb0OBMhkb6TIX+bY849UPAZhyI3aoV3HvreNXH+fQknmoA
        6kgQ++HmmK9H8fJ0DTRSlLlHu0oXx4R3Cw==
X-Google-Smtp-Source: ABdhPJyHqY72fbaXwdf2acp6AUOMOZIy/6NHYEKRPlWsRaHyfSV7hxwz4gN1tq143M0gfexGnALqSQ==
X-Received: by 2002:adf:aad4:: with SMTP id i20mr34082320wrc.402.1634542801469;
        Mon, 18 Oct 2021 00:40:01 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:2dd7:d5eb:6e87:f924? ([2001:861:44c0:66c0:2dd7:d5eb:6e87:f924])
        by smtp.gmail.com with ESMTPSA id z135sm6889997wmc.45.2021.10.18.00.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 00:40:00 -0700 (PDT)
Subject: Re: [PATCH v2 6/6] drm/meson: encoder_cvbs: switch to bridge with
 ATTACH_NO_CONNECTOR
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        sam@ravnborg.org
Cc:     daniel@ffwll.ch, Laurent.pinchart@ideasonboard.com,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211015141107.2430800-1-narmstrong@baylibre.com>
 <20211015141107.2430800-7-narmstrong@baylibre.com>
 <CAFBinCBwO0CJMPA3K6e8OxXcinzrA5LrSqaKu1XtZPWLXT8Krw@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <7a921d1d-84b4-c3e4-8f7c-10db5ad42ecf@baylibre.com>
Date:   Mon, 18 Oct 2021 09:40:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCBwO0CJMPA3K6e8OxXcinzrA5LrSqaKu1XtZPWLXT8Krw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16/10/2021 00:34, Martin Blumenstingl wrote:
> Hi Neil, Hi Sam,
> 
> On Fri, Oct 15, 2021 at 4:11 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> [...]
>> +static const struct drm_bridge_funcs meson_encoder_cvbs_bridge_funcs = {
>> +       .attach = meson_encoder_cvbs_attach,
>> +       .enable = meson_encoder_cvbs_enable,
>> +       .disable = meson_encoder_cvbs_disable,
>> +       .mode_valid = meson_encoder_cvbs_mode_valid,
>> +       .get_modes = meson_encoder_cvbs_get_modes,
>> +       .atomic_enable = meson_encoder_cvbs_atomic_enable,
> I did some testing on boards where u-boot doesn't initialize the video outputs.
> It seems that meson_encoder_cvbs_enable() is never called with this patch.
> meson_encoder_cvbs_atomic_enable() is called though.
> 
> From what I can see in drm_bridge.c [0] this is even expected.
> Does this mean that we need to move all logic from .enable to
> .atomic_enable (and same with .disable -> moving that logic to
> .atomic_disable)?
> 
> The same comment applies to the HDMI patch.

Good point, I'll fix that for both patches !

Neil

> 
> 
> Best regards,
> Martin
> 
> 
> [0] https://elixir.bootlin.com/linux/v5.15-rc5/source/drivers/gpu/drm/drm_bridge.c#L717
> 

