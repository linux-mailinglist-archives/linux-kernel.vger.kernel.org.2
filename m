Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1593A27FD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 11:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhFJJOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 05:14:43 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:39861 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhFJJOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 05:14:42 -0400
Received: by mail-wm1-f52.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso6049810wmh.4;
        Thu, 10 Jun 2021 02:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FBbTEMnsb2ggh860cgZ29dfHltR8ip05DHuNrwJxSGA=;
        b=HKPU4y/ltJX4LH6b2iBOVUVafQKjBqYwOGxnxqMCz7IdsQvtbGfu8NBJVrcAFNmVeY
         iHlbRQXEf6z5smPUvnlauCp+bzdb+JBhY3biq+TSYvPgzF2q6ZKLn9fSoeJoJmBcfWSu
         XLoMpgsCiQJzndS9HVfRcu2P38dkKgRWdNZknVa4ZrFbH/iWpDkpp09edTEk0JBedQWV
         SRcIXZTldJyiT/2yf9UPTbbJv1srBPXw1vYuT0NDxM5T0KbVv735Wp2HguaTDbwGgt9O
         MQgdGIEZa4rp/4QaYmSa1gCruQbdEbLDiDPaNW9FlKsZ94RAmsyMCUTo/8VTiAU7o9No
         KIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FBbTEMnsb2ggh860cgZ29dfHltR8ip05DHuNrwJxSGA=;
        b=jarF996bNT6f+UOWMmPXrRL6NyPmg2B6thCy2Y8VcTkvPG6CEBMvZyAaKW8t9Znk41
         lrP3JcheclU0sWVkPVCQatYTR6ZNYF1jGTsCc9coGPKkkCbiVit4Th94FZb3rb1yPRtE
         2SfMkQLnzMskUPCUvWNmcJS8Yy79Zmo7iS6n2V+vu7n53YmoNh9Iww54VF6Hw7AuPBtn
         nsjkwIC6nQUNHGZoryA59+7a6qZjpn155ThmDxGfq+30bDfHtnqR1zFg07TzBqgi3OQT
         I88lV6gqtrIYn8xTlB7tmEWDK14RzDC5HIUWy9DNN6S+NncmbkpEkYZvYhbyRmVu9dtT
         CTZw==
X-Gm-Message-State: AOAM5309WThmA+LpTnUL5Ii/3agHh2gjMqXXOze0s/P0hd5MZ1YAsjIC
        7XDxYYZQN8++yoY2R5cssJE=
X-Google-Smtp-Source: ABdhPJyguF6nrGNiftYxWcwuL3XoumPAgYke+ltF2+g/NDmaScu9ZkK+KJiNz0fSi42lC/YWc5IA4g==
X-Received: by 2002:a1c:c3d7:: with SMTP id t206mr14053277wmf.23.1623316293433;
        Thu, 10 Jun 2021 02:11:33 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id o5sm2799219wrw.65.2021.06.10.02.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 02:11:32 -0700 (PDT)
Subject: Re: [PATCH 1/2] arm64: dts: mt8183: Add kukui-jacuzzi-cerise board
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
References: <20210604052312.1040707-1-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <5524c45b-0517-f2ff-b6dc-b2129fbd5d05@gmail.com>
Date:   Thu, 10 Jun 2021 11:11:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210604052312.1040707-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/06/2021 07:23, Hsin-Yi Wang wrote:
> Cerise is known as ASUS Chromebook CZ1.
> Stern is known as ASUS Chromebook Flip CZ1.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> The difference of rev3 and non rev3 are the audio driver they use, which
> is not added in this series.
> ---
>  arch/arm64/boot/dts/mediatek/Makefile         |  4 +++
>  .../mt8183-kukui-jacuzzi-cerise-rev3.dts      | 24 +++++++++++++
>  .../mediatek/mt8183-kukui-jacuzzi-cerise.dts  | 24 +++++++++++++
>  .../mediatek/mt8183-kukui-jacuzzi-cerise.dtsi | 13 +++++++
>  .../mt8183-kukui-jacuzzi-stern-rev3.dts       | 34 +++++++++++++++++++
>  .../mediatek/mt8183-kukui-jacuzzi-stern.dts   | 34 +++++++++++++++++++
>  6 files changed, 133 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cerise-rev3.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cerise.dts

Both files are identical. Can we merge them and use a fallback compatible, or do
you expect changes to the different revisions in the near future?

>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cerise.dtsi
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-stern-rev3.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-stern.dts
> 

Same question here :)

Regards,
Matthias
