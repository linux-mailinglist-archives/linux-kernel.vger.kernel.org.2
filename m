Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C6B403C51
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 17:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351957AbhIHPMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 11:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349308AbhIHPMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:12:46 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACFCC061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 08:11:38 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id q3so3405227edt.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 08:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=I2FM/c/lyq+wiSWHr+eS3OSV6CCy3Zk/GIi/tQYaLjs=;
        b=WL5L7e0XBT7UCN92kDkzg6MZthdrzTZPAfM2g43YzvyGXX0WzUU3/BVkEYHSSUhESZ
         3ySc366zPoks/eVrnBSzFl/m6JmFZVo2QghUdvItPC5L0Q6ZAt7wpHo0Ht6Tsdk3sipH
         8IU+/w5Bz4Ki9dHyPO+BJzELB1eUjsWlVpxHeReghK9NwgcQUOCsY9rutysXAnLfBZRF
         NT8lD0hg2mf51SL3XKttd0vUNCGq0flFPvCBAKtthIffi//RRlnOd/KLCrQ6L4WxW5+r
         zUf3z2y9bCvJch5p2Wq7OR4wObNCXZdq4P7rbiw2/5cuYwK5GphgUN3CJJM7AC/oK8pa
         1gBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=I2FM/c/lyq+wiSWHr+eS3OSV6CCy3Zk/GIi/tQYaLjs=;
        b=XuCzytJRYu6KdN7092taqMNZSydeNYEbqNG3ABWKflwzh5nP/j61TLOPgMohRiZyFB
         b5g/bRMlF7+5r4pL8Oc1abRRoH+hBe0Nv/bn7Vd3QR48tPh13Q5OOqegknDZvd8vxe8T
         Rk23F3xWaYGEc8JhzQQaJjZcs50TfZB3fT4LBAFsa6mEeAJoCdK4CbU1mK1ddU/cEUE8
         yQyfDz7KBIdfKFX+S+QHqpL6lCK0UyGO5iTI0Rq8B4lfAAWHQ8xwbpobix0KnAWosooM
         MUYrM1x2rj2j05dNSFGev2KVawYkmpiXEHC6/H0wAd+Phn47s1amHY5T/d5vMVYL11S7
         Juxw==
X-Gm-Message-State: AOAM531MzyEwTnwtRlfrX3+DmF0kzsbtiBylY/EC5bf007l+9lF0+hTm
        xBhFLBxuIqdYQbq7AnGRW/svzIM9mcEaaNsnYrI=
X-Google-Smtp-Source: ABdhPJxCWG/V0HLoS7zYbhXd8v38UTjOope8dswZdvTp6dZ4Yn405XoctIAEMBubHd6TocpE8EDAP7VIALQcl3Wgd1M=
X-Received: by 2002:a05:6402:26d2:: with SMTP id x18mr4290153edd.195.1631113896732;
 Wed, 08 Sep 2021 08:11:36 -0700 (PDT)
MIME-Version: 1.0
Reply-To: godwinppter@gmail.com
Sender: mikelekwe@gmail.com
Received: by 2002:a17:906:2b01:0:0:0:0 with HTTP; Wed, 8 Sep 2021 08:11:35
 -0700 (PDT)
From:   Godwin Pete <godwinnpeter@gmail.com>
Date:   Wed, 8 Sep 2021 17:11:35 +0200
X-Google-Sender-Auth: AgugE_VMpVqZN70kpcS-Hq7HM_k
Message-ID: <CABCVdAGoaArnjtpzg_970+vUUk7H_1R=JErCVnOoFCy5giaRwg@mail.gmail.com>
Subject: Eu preciso de sua resposta
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Meu bom amigo,

S=C3=B3 quero saber se voc=C3=AA pode me ajudar a transferir o valor de (US=
 $ 3
milh=C3=B5es). Ap=C3=B3s a transfer=C3=AAncia, temos que compartilhar, 50% =
para mim e
50% para voc=C3=AA. Informe-me se voc=C3=AA puder me ajudar para que eu pos=
sa
fornecer mais informa=C3=A7=C3=B5es sobre a transfer=C3=AAncia. Espero que =
voc=C3=AA possa
trabalhar comigo honestamente?

obrigado
