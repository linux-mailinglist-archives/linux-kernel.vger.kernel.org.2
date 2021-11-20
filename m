Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CDB458064
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 22:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbhKTUzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 15:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbhKTUzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 15:55:53 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19254C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 12:52:50 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id t127so7847464vke.13
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 12:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nlXhJrN16PQPpob3r63cbJXa1Wu0XTp+D9+B/U7md4c=;
        b=nKUwqawC2adgMic4OmEC5Ihy7lZEeFe57URG6BjPs9k83fSqGdwmeF5D/YiQW74Yu3
         wf3zG/KWkfAlMu800mkMyTsHbsy1O673rb9IkEOI65WxrkJrngQtdd+IIME3/6d1kB2a
         K27Si6IhlBl9Y8zWvbUQOFRLerk1ah64sJ8sMFSNiD8VVDCmM1UzHYKlUYWgmBAsBQXi
         waSpqWe5BaB7j5/Q3pbRzHgqQxXu6eH7yhjqg/C8mAGdu7txZCWqbwt0JMD+wkafWwcO
         +2l2NqQkC+lkUgyCN/AEWjg7DxIHUzCYTogm510052tr8B/gDvQVAT8P8WGo8yT+wyiU
         JZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nlXhJrN16PQPpob3r63cbJXa1Wu0XTp+D9+B/U7md4c=;
        b=3fwG6wIKHvlUskZewBM/eIuihYOUMR1d0b1SxugSXDnBqHwxfnLuj4JHRXbzubuXde
         e2Uy1iaFLhQr1FRFdWdjYKH/3oep4vWAJysknX5Oc/V/5qrLjQTboPo3nZ9rWi0dP1B0
         HYddvgHB7QGjgnaowy3SE2T944nDom9nboIqmL2AJu1rrNdXCEA2Wd5g2apMgDVX/rtA
         l5UlW5f3lL28j74qHT2ZW0PZkLBxM8ixSMCgLEwJbWJOjthJwyOXZTnGVyMmjg3MPKIT
         3m23Z2P+sPbl2TUAaO6V7hpb/r1qncbp5+l1jbg0wn9qmxjwkNVopG9cujUDpxOMHa2+
         J6Bw==
X-Gm-Message-State: AOAM530ZZh9ObqOxO3yU1iI5JQyLXl4hekJTZJwU+ml8hjscAeHB17kP
        7CA/H/KwoHl4NzxDUJzwLvVO4yOPiBU5dA/oUKY=
X-Google-Smtp-Source: ABdhPJz+UMtqT77EBvVpyNIqPJxdznhhQCkb44xSHR8cA7amX3jy5bHgg3Z3XNHf9Lvlg3dbk7Kkcm60dBs6FUpQvgQ=
X-Received: by 2002:a05:6122:8d6:: with SMTP id 22mr138498230vkg.21.1637441568562;
 Sat, 20 Nov 2021 12:52:48 -0800 (PST)
MIME-Version: 1.0
References: <20211120193916.1309236-1-aford173@gmail.com>
In-Reply-To: <20211120193916.1309236-1-aford173@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 20 Nov 2021 17:52:37 -0300
Message-ID: <CAOMZO5CE890CygcP=VNgiqw9yDCZmJC9b-=OzBDRQSe1GHg8HQ@mail.gmail.com>
Subject: Re: [PATCH] soc: imx: gpcv2: keep i.MX8MM VPU-H1 bus clock active
To:     Adam Ford <aford173@gmail.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Sat, Nov 20, 2021 at 4:39 PM Adam Ford <aford173@gmail.com> wrote:
>
> Enable the vpu-h1 clock when the domain is active because reading
> or writing to the VPU-H1 IP block cause the system to hang.
>
> Fixes: 656ade7aa42a ("soc: imx: gpcv2: keep i.MX8M* bus clocks enabled")
> Signed-off-by: Adam Ford <aford173@gmail.com>

This makes sense:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
