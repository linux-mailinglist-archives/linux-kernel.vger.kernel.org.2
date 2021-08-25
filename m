Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B6D3F7ACA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242163AbhHYQjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242059AbhHYQjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:39:10 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368D2C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 09:38:24 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id m26so234420pff.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 09:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9Wr1+WXUoypE3YQABXETIrsp7QWtSDH3brrFfWMwZas=;
        b=pcX9nw/wLqZueDexjR4bJD9NMiW7Drxh2rIqEQFNQe4Ek1potnkZTfwy1O7EVoctpd
         93qvarZTUbCRht00dTuDJ5Yp4w2UaqsHIowBw0vFDQAZ/Gh8cuUfa7jrs34ItAx+cRjc
         S0lPeImczmQVYkECB7KUMNhYmHenO0X0rp80hoFrVRmIEwXuEnofxhCK+uqxz6peJ8hY
         OWzGWT+Gc8nenen16Szd4MZPfhFFSxBgtr1qVG0yyo90TJLbzycr2fqVcGj9Fqd+KsQb
         UXDmLJtA1jHRJGh937e3YMTZ8Fr5o5U+B7BdeGSWlVVRYg9xtn3n8BD28hT8JLHliP5H
         dujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9Wr1+WXUoypE3YQABXETIrsp7QWtSDH3brrFfWMwZas=;
        b=IEF2aDYG8OQ/zZEvUN/u4gyBRQO8vtJ1NGCy+9LxTwmm+gsa+b2xSBldSfoqaoVSLM
         L00IARAJOK0w2/7JZgLeR6aTdS5h3fgC4RmH4l7bV2rv+qlse8aXz2ZqZvwxljROrnDW
         +wHEk41yMdzdcEAv5LUXZ/MCtw7D6dlHYhGMDhVVdbjLeVE5WYsmfq/YyApIcgPm0om1
         /Y5mMQ5nMqr1JAiTrG1LHP+S9qOSaJ+gRzX46TscYvIDN/fLNusicR+JCRFaGBd314X1
         qdSiGRmWK15PLdPySh3/ajc9KZ5FZ0f9wh3NjJv2oAeUHHz/ajqcPskPYTRrLABRYv6g
         MTRQ==
X-Gm-Message-State: AOAM531lNu/lRj5QfqQr2B6mX7HdznUb7t0jIRjeqhZAwkWrcMMEwmgc
        TH+SipOlQOhxTqsDUBZJvzI=
X-Google-Smtp-Source: ABdhPJxQ3FMfF0LK750YP8PbTk5UP7c89+njt55GomboAUd7/c6VbmsbI71FXUbUz7zVfF1m4GKjXg==
X-Received: by 2002:a63:1a65:: with SMTP id a37mr43248868pgm.338.1629909503729;
        Wed, 25 Aug 2021 09:38:23 -0700 (PDT)
Received: from [192.168.1.22] (amarseille-551-1-7-65.w92-145.abo.wanadoo.fr. [92.145.152.65])
        by smtp.gmail.com with UTF8SMTPSA id x189sm349491pfx.99.2021.08.25.09.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 09:38:23 -0700 (PDT)
Message-ID: <7a2f972d-fdd0-d0f7-cac2-1989980ed872@gmail.com>
Date:   Wed, 25 Aug 2021 18:38:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.2
Subject: Re: [PATCH v4 11/12] [RFC] firmware: arm_scmi: Add
 sync_cmds_atomic_replies transport flag
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20210824135941.38656-1-cristian.marussi@arm.com>
 <20210824135941.38656-12-cristian.marussi@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20210824135941.38656-12-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/2021 3:59 PM, Cristian Marussi wrote:
> A flag is added to let the transport signal the core that its handling of
> synchronous command messages implies that, after .send_message has returned
> successfully, the requested command can be assumed to be fully and
> completely executed on SCMI platform side so that any possible response
> value is already immediately available to be retrieved by a .fetch_reponse:
> in other words the polling phase can be skipped in such a case and the
> response values accessed straight away.
> 
> Note that all of the above applies only when polling mode of operation was
> selected by the core: if instead a completion IRQ was found to be available
> the normal response processing path based on completions will still be
> followed.

This might actually have to be settable on a per-message basis ideally 
since we may be transporting short lived SCMI messages for which the 
completion can be done at SMC time, and long lived SCMI messages (e.g.: 
involving a voltage change) for which we would prefer a completion 
interrupt. Jim, what do you think?
-- 
Florian
