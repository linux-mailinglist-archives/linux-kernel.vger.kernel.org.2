Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCCB3AE8BC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhFUMIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFUMH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:07:59 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BC6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:05:44 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id r5so29824650lfr.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jYDncvORmzd5e5fXA1auwQJnxSuJ8MfUvv0XD0iPqS4=;
        b=uHONv/es6xb41PpyPYhMkXZFI9wFXIzSZQQ6OdTgzDZ0/0RE6TFUmthTGW2AEucsLN
         JOW0GKx5MoCi49GkrwiGyGRauwPUuW2TNWh+GzfNWaIfJ9slg1WCapIU17DyIBEsjBx1
         6uYL3zPiMHdkqimQ4+h7JhDZKXgosi0I/FxBDYW+7eBNJ2hefNI6W6OwVYhnle6asNoY
         tmrP51bwNG54PSKlHS+2bnEHJ0kDwls6nPlHMwiwwAKR7cyjJx7qUB76+hPymTShn/4e
         FQtiyVZYwD1swPYp4KLSodtj6w9QENIIPqoIacAzqj1RE9vUATcA8T8g7Si2oJ3sJHSO
         +53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jYDncvORmzd5e5fXA1auwQJnxSuJ8MfUvv0XD0iPqS4=;
        b=G5y+57/dIVtlKHff7bdacWGtQyt1QlohbhSOSl7lDjS3wo/qx19vvRVh58mBdwD7iM
         LTbFzJPp5ETb/NNHaUjMCz7zSxLFbKTTRqRkySeMQSpvRt150RU/JMerHI3shW8QBHfS
         nyMZcSxFL44bcKvJdbYxIwq2LPm/GiZT8rB3JjX+QciMvJJ/Ab3lwLqHr1cOhxWH87oi
         Lz79f5nkrYPKA0BWLa6Kk9MKJbJPKUYCn3+RgUBuuEAMMUMOyAC0JUYJSRauQvx4mZxl
         j4uNNxK2uJI9h0xMdlX4SxIxSMta3F1uZfAn/tki0Ewylur1eTbvm1c/82tKTkB+dS+7
         ueww==
X-Gm-Message-State: AOAM5321GAtqP/YOklzZczDyiV/O10hHNu0RJ/aHKhpIm4OQubKiUN5N
        0HxHeiz5d8qtKgCu0OwDOJ7QWz8jz4s=
X-Google-Smtp-Source: ABdhPJzOReNuf/i0DuPYDUXxPDdtD8UQ4GZ5NludJvFxaHVLhNw8ePVoqBp4FPAWBJJ5GQaZIt9SYw==
X-Received: by 2002:ac2:5581:: with SMTP id v1mr9008597lfg.414.1624277143054;
        Mon, 21 Jun 2021 05:05:43 -0700 (PDT)
Received: from [192.168.2.145] (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.googlemail.com with ESMTPSA id t3sm1857488lfl.78.2021.06.21.05.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 05:05:42 -0700 (PDT)
Subject: Re: [PATCH v1] regulator: core: Add stubs for driver API
To:     Mark Brown <broonie@kernel.org>
Cc:     Thierry Reding <treding@nvidia.com>, linux-kernel@vger.kernel.org
References: <20210619124052.1354-1-digetx@gmail.com>
 <20210621114659.GE4094@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5dd6145f-046f-9ed5-9f8c-58cf096287ab@gmail.com>
Date:   Mon, 21 Jun 2021 15:04:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210621114659.GE4094@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

21.06.2021 14:46, Mark Brown пишет:
> On Sat, Jun 19, 2021 at 03:40:52PM +0300, Dmitry Osipenko wrote:
> 
>> +static inline struct regulator_dev *
>> +regulator_register(const struct regulator_desc *regulator_desc,
>> +		   const struct regulator_config *config)
> 
> Why would something be registering a regulator device without a
> dependency on the regulator API?
> 

For example if regulator device registration is optional in the code. We
don't have such cases in the kernel today, but I decided that it will be
cleaner to add stubs for the whole API.

The point of these stubs is to fix the new compile-testing problem of
Tegra regulator coupler drivers. The drivers indeed don't depend on the
regulator-driver API since the regulator-consumer API provides all the
necessary stubs, but now drivers use the regulator-driver API too. The
dependency should reduce the compile-testing scope, IIUC.

If you think that it will be better to add the dependency to the coupler
drivers, then let's do it.
