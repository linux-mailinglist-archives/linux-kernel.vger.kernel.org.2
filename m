Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3F5438F0F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 07:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhJYGCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 02:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhJYGCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 02:02:01 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7201C061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 22:59:39 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id e2so19788243uax.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 22:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=RuvzlfukE67G/bE78HD8E3x3H683hittFC0ADYk7uRw=;
        b=KcV121LLb1pDqiLt77bJK4hpiIA0hrtOUBqVAM6bXlsoR3llEQ7ssfyI9G3E0R7Mzh
         T9hpOMaiKSr6J3VHZPyGsVxp8TMo2APZ6zbU7j5z8rBGkQqZ5IOz7xe0il9/D1/ZnHRL
         eUX0xG1auyUPcb7mf+73g3engf+nDI0IgHBMAaMzu6JEWZS7EyblPtlS0Ebrb+p+ixAo
         q42gf6gaSta65Z54VBpvLU5LTbOAVnPRvLw23vkqqvoGJJwKXa/Z6VeWVG/o/uplxukk
         r48Eo8v15f2f5GP2rFieNNtaZ0N+cWZ5Cvw32GwEYA7oqqiEhrWeFOdvGqNI9ye9htmp
         JZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=RuvzlfukE67G/bE78HD8E3x3H683hittFC0ADYk7uRw=;
        b=FqJzOEpeqto+vCPYAIiFrfhPhGAicxX2KgKQUgDjtZjuwE/U3z/Lq3PVOObeGIkART
         un0cKVF9NOHOn/2OvB+q4CJl3AsuWvYEVMcdkGJ+9PLmPFrWZRc2Fq1w1QTNsUntr99k
         0MHLyy3kIBakT34d7Zf3VB5z6+R8/5tGQt6zxPmdQvp9J0mEvrmdw7hHyCbdg/zVOBk2
         0F+9L6In2/PB5jqmrntGk4jJl8BCy5CWLyL2tGSVYEQ2etggOg6vsgmujk+H2Q9qulqr
         +ayJEkKSRMgWEa6jrUgddvkJ9o1whObbG+DyqaSnv3dCaSBPf4fQpAUjbsVNlgHgyYKG
         VVEw==
X-Gm-Message-State: AOAM531jHBEB1gTlffhKnrz/r7ZgCVsoym5JKqz9cHcv0mFgbPYgmWQ2
        n599sikUHmTJUTkQAffjUKM+yytrJ4tV3KNiZzQ=
X-Google-Smtp-Source: ABdhPJwsdOp4cCSEY1bbQtWY1Z9A4Zd8I18SwhsaZqFVSMXOETYlDz9xSK78B87f/yaOWiCYAtyq9FNufTilZK0MvB0=
X-Received: by 2002:ab0:ec:: with SMTP id 99mr13061856uaj.46.1635141579101;
 Sun, 24 Oct 2021 22:59:39 -0700 (PDT)
MIME-Version: 1.0
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 25 Oct 2021 07:59:28 +0200
Message-ID: <CAMhs-H_StRmvmRZKYdsWXsXBDY1-e0zF32OfsBHyOH=2hrXKvA@mail.gmail.com>
Subject: staging: ralink-gdma/mt7621-dma: some doubts about this two drivers
To:     linux-staging@lists.linux.dev
Cc:     Greg KH <gregkh@linuxfoundation.org>, NeilBrown <neil@brown.name>,
        DENG Qingfang <dqfext@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_van_Dorst?= <opensource@vdorst.com>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'd like to know if somebody is really using / has real interest in
Ralink/Mt7621 drivers related to DMA: 'mt7621-dma' and 'ralink-gdma'.
I haven't seen any kind of effort (more than achieve trivial
checkpatch issues) to get these two mainlined. Personally, I am not
using these in any of my mt762X related boards. I think these two were
added by Neil because he thought they might become needed for gnubee,
but they are not (Neil, please, correct me if I am wrong). I am asking
because I am attempting to properly mainline mt7621-dts and if nobody
wants to take care of these drivers I will submit a patch for removing
them and clean their nodes from the device tree file. When there is
real interest, a driver with the proper dts node can be properly
submitted.

Please, let me know your thoughts.

Best regards,
    Sergio Paracuellos
