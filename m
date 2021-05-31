Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCBE395AAF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 14:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhEaMiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 08:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhEaMiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 08:38:18 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B530C061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 05:36:38 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id z137-20020a1c7e8f0000b02901774f2a7dc4so9464780wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 05:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=V+ZL6IBlYhDhqaW2K8qSQL0I2+furW7I5Lbh2PK3hX0=;
        b=T0GopNvWjoEs/U+eUHkPvnEgWjOMnUjGIPBXStWTGj8Pn+KXUqBI8MzacouM+PVxbP
         M4wr8YIaCiWW4ye2v/awr83XvXC71vMNTV8jukygzzg0VL6dRzVUaGKJHPGdt97wQwO/
         f85H6sLjJP96Mfj7qQRd8iG5Uh2/DJaMyJ/t6dJ1zzNlWHGQxN8KgfAUZDX9gwmCLLjO
         3jqWsK0ZzDQXTZ62A9MD7IgZPBhF/AhcO1c2fYHCIsHGNVokFLR0brZaCOBVuVxOJoKB
         S75Trc93F8ekKOt+p0s6Rw6Srj3qnh5azp89b7FuWtckoTgb9MVnHELP+eNH0rTr4L1X
         nNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=V+ZL6IBlYhDhqaW2K8qSQL0I2+furW7I5Lbh2PK3hX0=;
        b=uJBBtpaBWcIfC+nmRJZuo2dOQB3HnPorLCDCRick2wYFP/NF2QK83phJjYotPXBhxz
         X9JueZ69I84oHjDUBbaZBGv5qnajbRS+tHQGQ+ZUVx3xYZNCSr4Jf9iiIxvW8Y2mqslw
         cKHq2cR+5d778UBZNaBrMim/fTNNAITwV3wmLTz3ozywHKnnTHc8k0ZJvC7+dDvgqoqz
         mlRbW9PpVMQq0Lb/6BlCsu0DHwuouMOqPeanulILVhWBYjMd+F7ZG5xvdvktV0DU28gu
         VNdZ46mAgA6tgTpm71AKHiYpeNvfOXwPdrLsiXRQ6lb4tKyMCQWUzA2lchnr9O7GnShA
         gkiQ==
X-Gm-Message-State: AOAM532/EoCKoyKWIPOsFWOnE94GL7AnMBmmfVx116QQNJ5J8CW3FgWX
        l8NFp0Twrg1bHzLnEU1WRcfQW4YQ5TA=
X-Google-Smtp-Source: ABdhPJx68UrxVmlUHokWyP5SyNiRoCmw+0ajl0YASTeGoWbQEdJMBMmmM4itbAiXTZOP2BzQSEycow==
X-Received: by 2002:a05:600c:6d2:: with SMTP id b18mr10183230wmn.132.1622464596707;
        Mon, 31 May 2021 05:36:36 -0700 (PDT)
Received: from [192.168.1.152] ([102.64.221.114])
        by smtp.gmail.com with ESMTPSA id a77sm12559519wmd.14.2021.05.31.05.36.26
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 31 May 2021 05:36:36 -0700 (PDT)
Message-ID: <60b4d854.1c69fb81.27b96.0a03@mx.google.com>
From:   Vanina curth <risonnah.001@gmail.com>
X-Google-Original-From: Vanina curth
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Ello
To:     Recipients <Vanina@vger.kernel.org>
Date:   Mon, 31 May 2021 12:36:13 +0000
Reply-To: curtisvani9008@mail.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How are you? I'm Vanina. I picked interest in you and I would like to know =
more about you and establish relationship with you. i will wait for your re=
sponse. thank you.
