Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C2A35CA60
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 17:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243012AbhDLPsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 11:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240489AbhDLPsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 11:48:06 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06405C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 08:47:48 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id a6so13460307wrw.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 08:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y/5Z50hT8XgUDXDqADXHmHcFjdRyH1Ew3g+vGI2YvHI=;
        b=MFST10U88/SHQi3NPS+LstwNQOXwSVV1pw36E6Y62at+1lwNrnRsNZu+IEXozYTYlj
         a4E+/HxXPI1DC1LJLJsgjQncch5hfZkxsgX/kio/wyHMOI3u0b1Xv9TNUWxkP2aRmNls
         yEuOb01G14f8+Kwi8t9kVJpzVBINWLO/2UT7RRZFif51kEB/3YCKJRU7KW2sl0jLiKzG
         257E26rDNlHD/K+4BogMQ9xqwD9qMoZx6ruyzLCFypjJCnVikjIEEtLF2ZdFG+SeqbZg
         OWUeJn16xlg2H0DYZL9HR5U3rILKNS7GiNx6v7H6ArdrAJnIjLmQlI8NSVGX66y9i+bc
         0VGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=y/5Z50hT8XgUDXDqADXHmHcFjdRyH1Ew3g+vGI2YvHI=;
        b=tJRS56gr4Nf0bOZ6g3oVBizm2FIg4P4Qt+4OgwSFt+Ih46FHv/vdU3c8sqktvyV7vF
         gtZBUdQo8FHOaHG5Ez7oLYfYtdpE60+fJSQAGN//hNm6NVPI6YIXARyfRtzG/ZUxt2tC
         ghgjwJSrTnNLLIIwcfNtckEd1LPhVJAVuXINVkXqIBUdJkJiZTpAj276tIoiiDGaAUye
         OzGSTRoMD62q48jJI501/pz8Jz4Mg2LBUPU01DIFIUWknqYVnipEk/1wmEfXjS0KPxEq
         dRe+0a2bMoDQDHZZ+OuNenSYxR8kolVjg/IvdBOjJ9OmoGR1lArbly4kOSb3i4E+ekt4
         8qDQ==
X-Gm-Message-State: AOAM532bAVZpkV+OVqdmvntLSvb+rd+nNUKM2ynrZ4vh3lje27pL5BxK
        CByP5D5gZ0KVUck8j/ThaZlgFg==
X-Google-Smtp-Source: ABdhPJzUvkIkCj0rMsw6OaH+49uNILOkPp6qGZpZMBcKowl9s74T5zr9/moXsBUJQOdNSGxyVS/srQ==
X-Received: by 2002:a05:6000:1acd:: with SMTP id i13mr31725469wry.48.1618242466693;
        Mon, 12 Apr 2021 08:47:46 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:4c21:b00e:ff79:bf20? ([2a01:e0a:90c:e290:4c21:b00e:ff79:bf20])
        by smtp.gmail.com with ESMTPSA id t19sm1522421wmq.14.2021.04.12.08.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 08:47:46 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] MAINTAINERS: add it66121 HDMI bridge driver entry
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        paul@crapouillou.net, robert.foss@linaro.org
Cc:     jonas@kwiboo.se, jernej.skrabec@siol.net,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Phong LE <ple@baylibre.com>
References: <20210412154648.3719153-1-narmstrong@baylibre.com>
 <20210412154648.3719153-4-narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <bb9196e3-e2d0-e44b-0cf1-cb469ea2edd7@baylibre.com>
Date:   Mon, 12 Apr 2021 17:47:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210412154648.3719153-4-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2021 17:46, Neil Armstrong wrote:
> From: Phong LE <ple@baylibre.com>
> 
> Add Neil Armstrong and myself as maintainers
> 
> Signed-off-by: Phong LE <ple@baylibre.com>

Obviously:
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9ae8444c96b4..ff6450c83049 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9515,6 +9515,14 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
>  T:	git git://linuxtv.org/anttip/media_tree.git
>  F:	drivers/media/tuners/it913x*
>  
> +ITE IT66121 HDMI BRIDGE DRIVER
> +M:	Phong LE <ple@baylibre.com>
> +M:	Neil Armstrong <narmstrong@baylibre.com>
> +S:	Maintained
> +F:	drivers/gpu/drm/bridge/ite-it66121.c
> +T:	git git://anongit.freedesktop.org/drm/drm-misc
> +F:	Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
> +
>  IVTV VIDEO4LINUX DRIVER
>  M:	Andy Walls <awalls@md.metrocast.net>
>  L:	linux-media@vger.kernel.org
> 

