Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0421542D08D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 04:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhJNCms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 22:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhJNCmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 22:42:47 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505AAC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 19:40:43 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id u21so17206564lff.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 19:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=B3GY5pHxl40fgyTRDEfHUIewqx+99afdPdvQA2cgGa0=;
        b=SNWsvxpqlIRG2J0jMXT0xpTFXBNUdUKAItYz1yvNNptc2JyeRW9W1cmg35ne1wM+qn
         dXJvD/0lQgG8CCK6/WdGiZimowMG027KseJoUStb7QlDvv4oeIe5cJ2Hbhf2jKrHA7H7
         vDLP9duOx6JA81j3vmv1E9x0MpgRhlri9B1PS/SZwWfvHulCfS53kpYnW4hSD81VNMvJ
         BqVmO9L7oCMb9LFHfhkNMD14+Mp0dHXll9bRnSukSo8Dgte2qibI8rztBrL9UDf17whL
         U4SF08ObtOXdPYSPdgAPyIWQDbVMH5ukn1HNHVXSg9ecgWkDA9aHmPB0WJH/A5DqkMnh
         hfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=B3GY5pHxl40fgyTRDEfHUIewqx+99afdPdvQA2cgGa0=;
        b=Fng6t8wY8DCXWzBSnH79e196UTXCfYFOY7cs8BdqgynfDAr20xRpRD86EkjkNHj/M6
         DDRrgLMNjfNa2BBh5fWf6A4Hb+tinbOIZlUK2WnbPkPwVie+2OV1I1BqvKDj36u5RC52
         qeX917/gZSocBMYA8cvOTDdYPhutCiWVmCkCIzx7I/254gwUIf17D8j+o0DGvGpQSiBy
         kOV00V9SEHrsv22RQTmTSiotUovuezT6OLJlPwGWvUZWq+J94mxdLPUjv3LC06c+gO63
         18/nivJzvW8H3fa5K0VkIHbEXWS0DUM0hRmuLGKkkpAsipxH5M5EXDyuTkPaJFsm3rOY
         3FRQ==
X-Gm-Message-State: AOAM532WzZbKoWdbJrXQ32Oxz7d0fpYuJDyALA9xrbkcBMqXL4i4v1Hw
        LsrjkdXb/dQXgRENMERtUh3vVhWw6b14bDBAiu8=
X-Google-Smtp-Source: ABdhPJyaCM+AYIAdKFkBFBzgHLF6VQbiL8QvtkQqWxgslo6Y4u7PAi4l3ASfaHDibX0iB7/9qsWwd6YoOo0WzlWFAEE=
X-Received: by 2002:a2e:910b:: with SMTP id m11mr3214899ljg.11.1634179241773;
 Wed, 13 Oct 2021 19:40:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac2:414e:0:0:0:0:0 with HTTP; Wed, 13 Oct 2021 19:40:41
 -0700 (PDT)
Reply-To: sgtkaylam28@gmail.com
From:   sgtkayla manthey <sgtkaylam20@gmail.com>
Date:   Wed, 13 Oct 2021 19:40:41 -0700
Message-ID: <CA+RGHE-ZvTsbvAfS28HgOzaxSe4gd9BUaH8UZ3qodPscDPug4Q@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,
Please did you receive my previous message? Write me back
