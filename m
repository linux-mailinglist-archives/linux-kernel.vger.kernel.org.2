Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4514283F9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 00:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbhJJWIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 18:08:25 -0400
Received: from ixit.cz ([94.230.151.217]:50278 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230364AbhJJWIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 18:08:23 -0400
Received: from [192.168.1.138] (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 2562420064;
        Mon, 11 Oct 2021 00:06:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1633903582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uZj5d5AasDC0yGtneihJgs5zOpaWOjkQUqwj3rrpnMM=;
        b=ctj8Q1q+FWwxgLuXTSdKDPIMPQuYwmzTbF6ioCGWaU7IUFsJffa19IuaAv2Z5m3kxExi7v
        xp7dwlZ7TigZ2tdJy2wykGRuVL1+Zj8QscNQ7i4oPX4CTNxaHnW0pTDJm1gbmM2IjlNTlj
        f7yiqStARtCZONqFMHo7goTsExi/DNU=
Date:   Mon, 11 Oct 2021 00:04:52 +0200
From:   David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH] dt-bindings: reserved-memory: ramoops: Convert txt
 bindings to yaml
To:     Rob Herring <robh@kernel.org>
Cc:     Anton Vorontsov <anton@enomsg.org>, linux-kernel@vger.kernel.org,
        Colin Cross <ccross@android.com>, devicetree@vger.kernel.org,
        ~okias/devicetree@lists.sr.ht, Rob Herring <robh+dt@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>
Message-Id: <408S0R.DDH2XGNA3OQR3@ixit.cz>
In-Reply-To: <1633894316.420061.3158665.nullmailer@robh.at.kernel.org>
References: <20211009111927.53280-1-david@ixit.cz>
        <1633894316.420061.3158665.nullmailer@robh.at.kernel.org>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




On Sun, Oct 10 2021 at 14:31:56 -0500, Rob Herring <robh@kernel.org> 
wrote:
> On Sat, 09 Oct 2021 13:19:27 +0200, David Heidelberg wrote:
>>  Convert ramoops driver to the YAML syntax.
>> 
>>  Signed-off-by: David Heidelberg <david@ixit.cz>
>>  ---
>>   .../bindings/reserved-memory/ramoops.txt      |  66 ---------
>>   .../bindings/reserved-memory/ramoops.yaml     | 126 
>> ++++++++++++++++++
>>   2 files changed, 126 insertions(+), 66 deletions(-)
>>   delete mode 100644 
>> Documentation/devicetree/bindings/reserved-memory/ramoops.txt
>>   create mode 100644 
>> Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
>> 
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for 
> dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/1538758
> 
> 
> ramoops@ac300000: 'devinfo-size' does not match any of the regexes: 
> 'pinctrl-[0-9]+'
> 	arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dt.yaml
> 	arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml
> 
doesn't exist besides oneplus bindings

> ramoops@ffc00000: 'msg-size' does not match any of the regexes: 
> 'pinctrl-[0-9]+'
> 	arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dt.yaml

doesn't exist
> 
> ramoops@ffc00000: 'msg-size', 'no-map' do not match any of the 
> regexes: 'pinctrl-[0-9]+'
> 	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-bahamut.dt.yaml
> 	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-griffin.dt.yaml
> 	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dt.yaml
> 	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dt.yaml

doesn't exist and I'm not sure if no-map make sense for pstore ramoops, 
since it HAS to be mapped (if I understood right).

Binding should be right, I can send patches for fired warnings.

David




