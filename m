Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059553A598D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 18:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhFMQ0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 12:26:16 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:45732 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbhFMQ0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 12:26:15 -0400
Received: by mail-pf1-f176.google.com with SMTP id d16so8716704pfn.12;
        Sun, 13 Jun 2021 09:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aC2dhdspoUUA1LkjK2BRQaIt/hcnZcvsLvf5tjojtDc=;
        b=JWFwzc5GQCLvNHzO/T16pGnCD4oY9eqO+zFxYTckjqpTzL1s1Gisf/AXBDCZoG3OwR
         0iqwVqT8S/04DKdKIrgyP3unxVa2p9TPiqrSQiIm60IU7iY3cUuqkZdlk0ndZWuoS9Ao
         tNXJdkuJr9HEozxzkCgxbqmJbIY7sr3NZlCUi0/IhQucFRTtQv1zav1TgVCTRoSJNQYJ
         Htffw5B/gCU1RJUCP37B6HJrYwwc1fzBZn+OaiYx7vWdbStG9d5HHc1qyfEHeIfPZE5X
         LFDIeKka2AjUif9GbSls+DvgNVO7Rqbkg5gmuN3o6na2fUQLofQIbpBapD5cbfA/2CeL
         O0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aC2dhdspoUUA1LkjK2BRQaIt/hcnZcvsLvf5tjojtDc=;
        b=YmZjPqYdA/bz1afzBYorKizFts11P3kWIbdKrZUY0DsusQ/0+BRGj4G9agqlL5m75e
         wuzmK2ONicLlFAP4PqhDXyzAJxwy2d9hwuASQ0gZb1l3PCBeUf9/N4jDtfOATdfgT3QI
         3nMQXsvsYZYhVWvUO4YsuDadEyKV2bD3JKj2U4NSA6XlsD12ceIHRY7Sb1Ii3HC0g+4F
         AlCpkz9Cy2vXxpxRZj+zOTAe5E9C9uqAW/NGKrrO55vPZOFvpMywVldS6m++HvDkpJoQ
         M51g2R3MO7AQ85T/4J5EHMwp7DQKl7VTl0Ya02DfUJx11x7O5vqgzMwUuBhs3rhAPh0d
         NkBA==
X-Gm-Message-State: AOAM530jHHaPgH37NrgVxRkYuuiJ8Zrdh3PUL14nUptwvFYhq0bLeAtx
        NdTVDNpSHgbWFMQ6uv1CXem7whcIKyk=
X-Google-Smtp-Source: ABdhPJwAqTa0Aki/WnTbOlKBOM1XqAXtcWAY+bkkZqquksEz49o02cVPS9FamtqtArdKaBvu8j2n/g==
X-Received: by 2002:aa7:8881:0:b029:2f8:5004:9523 with SMTP id z1-20020aa788810000b02902f850049523mr6262285pfe.31.1623601380324;
        Sun, 13 Jun 2021 09:23:00 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d15sm10040644pfd.35.2021.06.13.09.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jun 2021 09:22:59 -0700 (PDT)
Subject: Re: [PATCH 2/4] ARM: dts: NSP: disable sp804 ccbtimers by default
To:     Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivek Unune <npcomplete13@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210613094639.3242151-1-mnhagan88@gmail.com>
 <20210613094639.3242151-2-mnhagan88@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <89d2a415-a9a3-f778-bd40-e39e01e219ef@gmail.com>
Date:   Sun, 13 Jun 2021 09:22:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210613094639.3242151-2-mnhagan88@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/13/2021 2:46 AM, Matthew Hagan wrote:
> The sp804 ccbtimers are enabled by default, however they may or may not
> be present on the board. This patch disables them by default, requiring
> them to be enabled only where applicable.

The timers are always part of the SoC, so they should always be enabled,
and if there was some board specific wiring, in that maybe one of the
times was fed a different clock source than iprocslow, we could deal
with that on a per-board basis.

If someone does not want a specific timer to be used, it could be
unbound once the kernel has booted for instance.
-- 
Florian
