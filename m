Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CA93F2DFC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 16:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240856AbhHTOYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 10:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237597AbhHTOYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 10:24:12 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4AAC061575;
        Fri, 20 Aug 2021 07:23:34 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id i3-20020a056830210300b0051af5666070so4288528otc.4;
        Fri, 20 Aug 2021 07:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LxzVE2tcDwLQcNWPqnkcWzfYNhi9aNKP+ZXfsVolznY=;
        b=TZWzk0OCE4ctaq9uuEIbOuYkIloX0HvdPbLPlCvlT29S+lKSbE/3gvZLbNYT8K6o6K
         WJoLh8oghL4Js0UgOS2rYHGlrVAia35fMgz5yCPkhjKrM8HfhQiJwyTN+3vwuWNqLGmp
         EJC/1T9ULjHuzSv9bvESKMqH3jc14RyXCj12lrqechvJyHRgbSw7ipDn0Xt2RCLlrIGM
         ie9WoALNT6pG7I0j9N/TQhUAypggPz12JTdRoaC8LcApGDKCZmUbfDyKYsKS5y/h9Q0R
         VjXkKd+z0bV4a1uD9cLGG8ze7fjq9KimJAXG2x8DReeBiwiplvgarmos2VPk8UR5OBsa
         xrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LxzVE2tcDwLQcNWPqnkcWzfYNhi9aNKP+ZXfsVolznY=;
        b=IfAi+0TeWGaCKOVbk+080rDQF9uc+XDkVtyv2wDFnwVUwMSUufEdNPza4//6D+FyTL
         ghD5N4f/HmdRJ3UI6/0IZ2Hjqk3rl5mu1jS8qDFrUJ3fR9B+5mWHxtcYpkrm3L4w7xYg
         Ja5DTCww/tCuqtzmPbHXivGmcsM5CuTumW93mIF2sMC5tLpDd+48VFzMcAeu1cXAPafG
         uIZUrBfmaoA3Oar8TueHqAyMQ2DbphxocKhO3o2YbW9hegTHq+ilD4pXrhn5DcG3z0XD
         FJJjpRijnQE2rhuynfsQPfeuwcX7h149vWbPRrjb71yGndveDhDWfZ472Ml6/akY1lGA
         toKg==
X-Gm-Message-State: AOAM533B7f2Aq/JXmnOd5yrkcv2Bxc9/WwEb/cFDc+r8UFoseb+X46GL
        AXwpsfK0uUXhXDm0QB3rwYVQP1YBor4=
X-Google-Smtp-Source: ABdhPJxQ57832FNZFZ6OwiX7NMl8p5OMcBSdvB2xyhlpR2/sOS5qngggzUMsdUTl4GDSPMw8VbG+6Q==
X-Received: by 2002:aca:aa88:: with SMTP id t130mr3285112oie.3.1629469413796;
        Fri, 20 Aug 2021 07:23:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g62sm1425284oif.14.2021.08.20.07.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 07:23:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: hwmon: merge max31785 into trivial
 devices
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jiri Kosina <trivial@kernel.org>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210819182544.224121-1-krzysztof.kozlowski@canonical.com>
 <20210819182544.224121-2-krzysztof.kozlowski@canonical.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <fffdaaad-ac75-5c2f-6a31-7cdc3e57de20@roeck-us.net>
Date:   Fri, 20 Aug 2021 07:23:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210819182544.224121-2-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/21 11:25 AM, Krzysztof Kozlowski wrote:
> Ther Maxim max31785 bindings are trivial, so simply merge it into
> trivial-devices.yaml.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>   .../devicetree/bindings/hwmon/max31785.txt    | 22 -------------------

Not sure if that is a good idea. It would make more sense to standardize the
properties needed by the driver/chip instead (see existing dts files in the kernel).

Guenter
