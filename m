Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC9639C8FC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 16:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhFEOQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 10:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFEOQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 10:16:48 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F8CC061766;
        Sat,  5 Jun 2021 07:14:44 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a11so10255923wrt.13;
        Sat, 05 Jun 2021 07:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AHObE04CnQ7sBWhLfOwE1pLlZHif1LMZSlIi89SV3Eo=;
        b=hPOvBLzV67HfYBd2PZZeO+GV+gClZ1ufh2tCDaFmFBT0w0PahMP6EiBnU/WSvj+txY
         mT8jLV84fW2FkWUBirTii5u0QZLAunNwXJbTWKxCB65/nhMcMcFG16YmJmlPVIRvq7gq
         c4DYXTKwdhyxcdQvQgM79AwIQ/uvsaERbwZvpAOsod7564bRyrtH0TWtA2OF8jj+A5Nj
         NURzz6dkKqDkevQZzE5dN77HT11Sed/vhNMcr5O36c1QgIxZhE39xvGFD+3mu76vp4xo
         TB/Q0ey8LbOVM3E5yyPABLg/hTLhzbvEQ/+Ypyxgb4LvOBF5UupD37o+OtUyhISVmiAs
         qrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AHObE04CnQ7sBWhLfOwE1pLlZHif1LMZSlIi89SV3Eo=;
        b=RiHcWFSOrM8pOAlQuoXoUa87kbwpC82cQl5/kI+iRIaiiLzlpyYofruG7Kn5+fcPN2
         PayCP1D7CsAsDsTAk8Nb8g3U1VRqR/Hd48kzVYzXqZRTJSOD6eaoob4d1khRS4WmbZpY
         qdBWMccVbH3zLpyvxYjQOySocH59F6xdO9YoW58kDd87rK/MlX5KcmX17JLgmEz/ZCDn
         Mq2aQzz6M1B1jtH8Zzu+rhCh6CpvXj6MzNhNCTmU4ST3nArnWNwfDejAExEDNoyyzUvy
         ahhZga8IN8F+VABqTWVT0oV8Lmq53Smjhwxl+pGAL4ug4+5fDgYJF48Tt3pRoQe2qq1w
         YCzg==
X-Gm-Message-State: AOAM531omZ1Yp2EOZlz1KzGKlr0mpHSr9V4K8kqBn/gDIc/1Z1I21jmY
        zVUxY0FKx9m8XkELFHnGqJvPDqy+E40=
X-Google-Smtp-Source: ABdhPJyQEVg8yFGhdE4mTQ1vOX08qQKIZ33qSADqUkHSDNJrXmsKDxLAXVY2ldIg7ON772RFIzK1/Q==
X-Received: by 2002:a5d:438a:: with SMTP id i10mr8751419wrq.82.1622902481624;
        Sat, 05 Jun 2021 07:14:41 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5aeec.dip0.t-ipconnect.de. [217.229.174.236])
        by smtp.gmail.com with ESMTPSA id r7sm7470496wmq.23.2021.06.05.07.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Jun 2021 07:14:41 -0700 (PDT)
Subject: Re: [PATCH 19/34] docs: driver-api: surface_aggregator: avoid using
 ReSt :doc:`foo` markup
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
References: <cover.1622898327.git.mchehab+huawei@kernel.org>
 <c42fe427e6538ce7914645468ef63f83254c26d7.1622898327.git.mchehab+huawei@kernel.org>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <91d72412-3bba-8a50-4527-7c8fb9fa54c4@gmail.com>
Date:   Sat, 5 Jun 2021 16:14:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <c42fe427e6538ce7914645468ef63f83254c26d7.1622898327.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/21 3:18 PM, Mauro Carvalho Chehab wrote:
> The :doc:`foo` tag is auto-generated via automarkup.py.
> So, use the filename at the sources, instead of :doc:`foo`.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
>   .../surface_aggregator/clients/index.rst          |  3 ++-
>   .../driver-api/surface_aggregator/internal.rst    | 15 ++++++++-------
>   .../driver-api/surface_aggregator/overview.rst    |  6 ++++--
>   3 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/driver-api/surface_aggregator/clients/index.rst b/Documentation/driver-api/surface_aggregator/clients/index.rst
> index 98ea9946b8a2..30160513afa5 100644
> --- a/Documentation/driver-api/surface_aggregator/clients/index.rst
> +++ b/Documentation/driver-api/surface_aggregator/clients/index.rst
> @@ -5,7 +5,8 @@ Client Driver Documentation
>   ===========================
>   
>   This is the documentation for client drivers themselves. Refer to
> -:doc:`../client` for documentation on how to write client drivers.
> +Documentation/driver-api/surface_aggregator/client.rst for documentation
> +on how to write client drivers.
>   
>   .. toctree::
>      :maxdepth: 1
> diff --git a/Documentation/driver-api/surface_aggregator/internal.rst b/Documentation/driver-api/surface_aggregator/internal.rst
> index 72704734982a..8c7c80c9f418 100644
> --- a/Documentation/driver-api/surface_aggregator/internal.rst
> +++ b/Documentation/driver-api/surface_aggregator/internal.rst
> @@ -87,10 +87,11 @@ native SSAM devices, i.e. devices that are not defined in ACPI and not
>   implemented as platform devices, via |ssam_device| and |ssam_device_driver|
>   simplify management of client devices and client drivers.
>   
> -Refer to :doc:`client` for documentation regarding the client device/driver
> -API and interface options for other kernel drivers. It is recommended to
> -familiarize oneself with that chapter and the :doc:`ssh` before continuing
> -with the architectural overview below.
> +Refer to Documentation/driver-api/surface_aggregator/client.rst for
> +documentation regarding the client device/driver API and interface options
> +for other kernel drivers. It is recommended to familiarize oneself with
> +that chapter and the Documentation/driver-api/surface_aggregator/ssh.rst
> +before continuing with the architectural overview below.
>   
>   
>   Packet Transport Layer
> @@ -190,9 +191,9 @@ with success on the transmitter thread.
>   
>   Transmission of sequenced packets is limited by the number of concurrently
>   pending packets, i.e. a limit on how many packets may be waiting for an ACK
> -from the EC in parallel. This limit is currently set to one (see :doc:`ssh`
> -for the reasoning behind this). Control packets (i.e. ACK and NAK) can
> -always be transmitted.
> +from the EC in parallel. This limit is currently set to one (see
> +Documentation/driver-api/surface_aggregator/ssh.rst for the reasoning behind
> +this). Control packets (i.e. ACK and NAK) can always be transmitted.
>   
>   Receiver Thread
>   ---------------
> diff --git a/Documentation/driver-api/surface_aggregator/overview.rst b/Documentation/driver-api/surface_aggregator/overview.rst
> index 1e9d57e50063..26415e1ab7da 100644
> --- a/Documentation/driver-api/surface_aggregator/overview.rst
> +++ b/Documentation/driver-api/surface_aggregator/overview.rst
> @@ -73,5 +73,7 @@ being a direct response to a previous request. We may also refer to requests
>   without response as commands. In general, events need to be enabled via one
>   of multiple dedicated requests before they are sent by the EC.
>   
> -See :doc:`ssh` for a more technical protocol documentation and
> -:doc:`internal` for an overview of the internal driver architecture.
> +See Documentation/driver-api/surface_aggregator/ssh.rst for a
> +more technical protocol documentation and
> +Documentation/driver-api/surface_aggregator/internal.rst for an
> +overview of the internal driver architecture.
> 
