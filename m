Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5E64273C7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 00:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243668AbhJHWcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 18:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243610AbhJHWcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 18:32:19 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E006DC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 15:30:23 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s11so4397307pgr.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 15:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5lX4WmVdA9s3zOOpVFvz6WSAhGtDP8pyzJp9HvydbOI=;
        b=P6tbI4GRMv5cxI2aSwa0R8ys9H6kQdPqaiB5eCCUh3wQpm+DaakG5FkGgAhYMihbeA
         Tb3KDDs1VxLmzD1sPDlCTDKPTAWU2gnVaLBL71VSThVAKefzJXtp3I1Bz4vyslMerQgg
         3aLV2VF/GNO9hehONdQgh4GPPW9F3y0oT6gAreyLZM/3E+OrBjAurxjZqDbIeH44I+ym
         xzekeAM6SgWTqmoas++ZigLXMdQPZIU6MnvoEDTWYXsCcqSSMLBzSA91eDcKbiGPliq5
         oiM9j3qQrShb+d0w/5SxtGM63anlKX45sT3/9aB0+dsjOfgTSeSSuthwEoQy6f6MRJpZ
         kDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5lX4WmVdA9s3zOOpVFvz6WSAhGtDP8pyzJp9HvydbOI=;
        b=6Kj1ix0MU7OACL27gHd9QdHi9Upy9sY1J0oS2ZdEbIhQ7djlOhvvQrHaBYlsEDQGDJ
         P2POWUQpuBIo8KWgroOOF+3cNtM59WR7/rZn0qmCsN9Zr8rQY45PH0b0bme10kCyDhYi
         cS1ahS7iJyxf1Um8jyVJDGC2rZrs6dUC4m55TXGhAVq5SmFzM4w+bZD0V7xUyHTWVvyv
         iO4NpIdfz7xYgaSs5SzvOXWnVetsyLXbL2Je6eRyr7Mm2kPfJLfGxKbTnriFlETwohfi
         AClX3Ov1r4XMxKGya8/skwkFdDYKizg0c4NRAtkB+qAT60UvOABnRU+g3tyAm5cDVikL
         MdJw==
X-Gm-Message-State: AOAM5309Z0cYseGNixFrZlCDZuqgq7kSAONAkUz/hOjeZqG2QSJ0C+S8
        +MsD+QON9H1NbWcwQm+WGUA=
X-Google-Smtp-Source: ABdhPJyM/XguqoXhYk/dTJstav/W4lJqXfPQC33PDz3PwV5yh4tPlZIOzSCu377jhSui7Bl20V9F4g==
X-Received: by 2002:a05:6a00:198a:b0:44c:ae90:85fc with SMTP id d10-20020a056a00198a00b0044cae9085fcmr12747026pfl.1.1633732223304;
        Fri, 08 Oct 2021 15:30:23 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id s17sm303480pfs.91.2021.10.08.15.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 15:30:22 -0700 (PDT)
Subject: Re: [GIT PULL 1/2] bcm2835-dt-next-2021-10-06
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20211006081849.1434867-1-nsaenzju@redhat.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <57bb52c1-8ab8-da43-637b-523d2304609f@gmail.com>
Date:   Fri, 8 Oct 2021 15:30:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211006081849.1434867-1-nsaenzju@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/21 1:18 AM, Nicolas Saenz Julienne wrote:
> Hi Florian,
> 
> The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:
> 
>   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-dt-next-2021-10-06
> 
> for you to fetch changes up to 1d71d543469cebed0c278b9b31c7a88306142121:
> 
>   arm64: dts: broadcom: Add reference to RPi CM4 IO Board (2021-10-06 09:53:36 +0200)
> 
> ----------------------------------------------------------------
> Stefan Wahren adds devicetree support for the Raspbery Pi Compute Module
> 4 and its IO board
> 
> ----------------------------------------------------------------

Merged into devicetree/next, thanks Nicolas!
-- 
Florian
