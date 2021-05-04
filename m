Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A37A3732AD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 01:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhEDXRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 19:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbhEDXRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 19:17:50 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E31FC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 16:16:54 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id l7so3730403edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 16:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0vYQM81JKDpeZvI/BHjN9+hVhpREG83q9qB5bkloA3Q=;
        b=nN2gb7zlX7Pe+PY4MD2ApEExctC4eYs2oAeqZ8WBvC2PQKCMH1bvdqHaRz+eGbZS5Y
         HcKeDP40KA7lyoUB4vgYqylgytiX0Xg5Gx+DWb/AwuP5XYXmuiR3OBjgtJVRlwYuK2ZW
         zaI4WwZyevEwMrS1aIyNrtuTBfoTmy9n+seZ0LcfodR5HgiVd8phKj5Ad760p0jg3Vyx
         8Dk2cN2l756PQ/uSynmwyhqst/futL2lK8COHsAE51dcePvoFI8nMGoCAd+n/MrOqmi3
         ZnlL+EpAiCSyptun/vKB5kQhRua9dKhnKGmw/b8hNqj8xohwPMGFjCuuDnOpzYtpgLwc
         xkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0vYQM81JKDpeZvI/BHjN9+hVhpREG83q9qB5bkloA3Q=;
        b=m7577aH2hQvo1rLC0B7x/rBm52RFaIhbkQKbm+2wC4N1QvTzINIlWGti89qQuSQ3Es
         KrtNahN4ZwVOUhEl1htilr9o9wbMVdmtxTa3iJGRnV+fvA1fe7UNYrK4pCutaW3W2d3n
         bq9lYptsVP6JDlIl8fwjycu6LASwvZv+j7MrqslYUDT+uqvU+EGoQHeOAHHdDQp4LRza
         oJ7suVVl/X2Nwk9GurciveYkzu+EgoF2lFxCm8lwmE6SOlfCGipxvqe1sDM6AgxXQROy
         LMy4njRmv4x2wvxR4md7JNEjmNzHzvxZkjMQYTsXBk6/ZTyjTwzDJf8yVwZ4/Qot7UFm
         Ykhw==
X-Gm-Message-State: AOAM533a14NPdTWROkloKEDRvDbTQRYhRQR4RyYUbcpu3eQqOG9nRg1a
        CyrGfyExa3pjDs+/83ULkFyPNZzZAIKKLjg7UD6pLA==
X-Google-Smtp-Source: ABdhPJzLAQ81WoS+DtV66dNFOc01dD7aX/1H5yIQGaIYMHwNeM+XUoQyQq0cVl+g0KdGb8FPxTll2ywYhEHVmtzvlK8=
X-Received: by 2002:a05:6402:284:: with SMTP id l4mr29035907edv.299.1620170213172;
 Tue, 04 May 2021 16:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200721034815.2045545-1-linchuyuan@google.com>
In-Reply-To: <20200721034815.2045545-1-linchuyuan@google.com>
From:   Chu Lin <linchuyuan@google.com>
Date:   Tue, 4 May 2021 16:16:42 -0700
Message-ID: <CAKCA56AziFJGnX6u5D35psboOUFZhSOGxpkb_4JaRo5mVk7fnQ@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: hwmon: adm1272: add analog,temp1-enable binding
To:     Guenter Roeck <linux@roeck-us.net>, robh+dt@kernel.org,
        jdelvare@suse.com
Cc:     Kais Belgaied <belgaied@google.com>,
        Jason Ling <jasonling@google.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhongqi Li <zhongqil@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Please review this device tree patch when you have a chance.

Thanks,
Chu

On Mon, Jul 20, 2020 at 8:48 PM Chu Lin <linchuyuan@google.com> wrote:
>
> Problem:
>         adm1272 and adm1278 supports temperature sampling. The
> current way of enabling it requires the user manually unbind the device
> from the driver, flip the temperature sampling control bit and then bind
> the device back to the driver. It would be nice if we can control this in a
> better way by reading the dt.
>
> Solution:
>         Introducing device tree binding analog,temp1-enable. If the
> flag is set, flip the temp1_en control bit on probing.
>
> Testing:
> make dt_binding_check
>
> Signed-off-by: Chu Lin <linchuyuan@google.com>
> ---
> ChangeLog v1->v2:
>  - Rename adm1272-adm1278-temp1-en to analog-temperature1-enable
>
> ChangeLog v2->v3:
>  - Rename analog-temperature1-enable analog,temp1-enable
>
>  Documentation/devicetree/bindings/hwmon/adm1275.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/hwmon/adm1275.txt b/Documentation/devicetree/bindings/hwmon/adm1275.txt
> index 1ecd03f3da4d..22ca5a321d5c 100644
> --- a/Documentation/devicetree/bindings/hwmon/adm1275.txt
> +++ b/Documentation/devicetree/bindings/hwmon/adm1275.txt
> @@ -15,6 +15,8 @@ Optional properties:
>
>  - shunt-resistor-micro-ohms
>         Shunt resistor value in micro-Ohm
> +- analog,temp1-enable
> +       Enable temperature sampling. This is supported on adm1272 and adm1278
>
>  Example:
>
> @@ -22,4 +24,5 @@ adm1272@10 {
>         compatible = "adi,adm1272";
>         reg = <0x10>;
>         shunt-resistor-micro-ohms = <500>;
> +       analog,temp1-enable;
>  };
> --
> 2.28.0.rc0.105.gf9edc3c819-goog
>
