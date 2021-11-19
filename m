Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D307545736C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 17:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbhKSQwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 11:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhKSQwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 11:52:49 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8330C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:49:47 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m27so45772571lfj.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=0ovT7bdCXjT3mE5QwCNdfr2daNZ4yh2Lm0JlNZFsvc0=;
        b=LAkff5whHdy8Dtj7kkPz4qTJEJ5wnS2buD9Wy5tUwDOR7NtbJDIbp63llLhjsgM3Ik
         H6HVfLhSAJ71iLq0VLeCI0DPI7zbfEG/qrW836o5PGnBrc/sKac9J1mvd5MZbmo2UFV7
         iW0lyeO+gvffQSzOeYKkXmpY37IY32TZuIkZNELTmfcVW0RQ3gGvACoUR2PgzisC5IKn
         xBzz0lMXxd0Ci6ycRQKa+vaPpUcSaFLEyz9Wl0MjKaxCU6jyIr7ibgGjaWK3yszhsZM5
         2HrhDV0/X8NQhcvZpmVGvwpp/jFoMH9nLA4lNxswkpcFPGPFD70xywV6lcXQZitHpkJf
         p8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=0ovT7bdCXjT3mE5QwCNdfr2daNZ4yh2Lm0JlNZFsvc0=;
        b=T84PB4zK0O/BBnY/SXWZX6268F3Fph9Pbzq6kkxoc4RQrPnZXVNLR+PzsshLMVcIgT
         zt2ygv0V4lmCi4A8nPHpyUE4VeBhwd6pBjlK3TE6DSUBdWJzTw8PuvTExTdc1uQ2Uu52
         zCYx4xHTta53iyR9fGEKKfIwhvo67G/UwTm1RMGaUj3zrqfv/0hTWzGkIBwV6fb25JIW
         wCbHQPHQn2tbIzFZupTEDYzktkwLRwWe2ZcQqshknQ3WdSBaL1NW/+7zxXoE0s5qVMwK
         g0xm/oLbcRR1muZLur8u/gOzZoH7iuXU3wT/Mx4dqtjIStBbMaNerBX5lQ9R/fxtZ/FO
         PWDw==
X-Gm-Message-State: AOAM531JF7pNzD4Ebd8FZrMnHtJGmQPkmMTEhKPo1omZpvTHuRFAZBr0
        Eb28WtKi78RVoFyhCvWTdZ1H7/Sde4rVhMx8js4=
X-Google-Smtp-Source: ABdhPJyZUe0jhag8UpyKx+wuSfR0U7SZKQOQqOIjsOtCrrFHqEZJBcORrjEUG9aUqlb+L2gyXu2vGIIDsnEQepmWTYQ=
X-Received: by 2002:a19:c704:: with SMTP id x4mr34477497lff.507.1637340586163;
 Fri, 19 Nov 2021 08:49:46 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a2e:bd01:0:0:0:0:0 with HTTP; Fri, 19 Nov 2021 08:49:45
 -0800 (PST)
Reply-To: hegginskate7@gmail.com
From:   Heggings kate <heggins35@gmail.com>
Date:   Fri, 19 Nov 2021 16:49:45 +0000
Message-ID: <CAH=nmxZgzPj_F1w9HfAR3hgn3H3wKp0D0nWN5KKzQSEjpDTM2A@mail.gmail.com>
Subject: urgente
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWVyaGFiYSB1bWFyxLFtIG1lc2FqxLFtxLEgYWxtxLHFn3PEsW7EsXpkxLFyLg0KaMSxemzEsSB0
ZXBraWxlcmUgaWh0aXlhY8SxbSB2YXINClRlxZ9la2vDvHJsZXIuDQpLYXRpZQ0K
