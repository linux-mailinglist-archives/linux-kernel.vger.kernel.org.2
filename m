Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9AE394DCC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 21:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhE2TLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 15:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhE2TLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 15:11:22 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2E8C061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 12:09:45 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n2so6623919wrm.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 12:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=V+ZL6IBlYhDhqaW2K8qSQL0I2+furW7I5Lbh2PK3hX0=;
        b=vOu5vvSArQSVfjpU35GFfT0nqI+M6iQODw3x/LXXJoXMdYMDcI+2m5QIqq1CdPpTLA
         NPDPBHe2A/I6stZ8uYY6qGcN1snBfLOYi/zqyy1MwhQfFJK7RPPyb7Yr7EocGwZ+PY+t
         2PfVK1FNBy3wAquJp0xGXOFyhfuXUGpo4eG0tbqdYKJoglKZ3rvi5D5/l+lHP/nRaFGA
         44O99NvjG69ZBTwLapbHsGr4Q4un0JGWoas6cP5Y1WARh3CbWDRLIgWt2vNnRI50PQpY
         YHDnZScm/xDkX7TOfnK1iQs87Bp9fwwk7CVd+NvBimqJNuCtIR3mJECcgH2wCrEJwX5u
         WD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=V+ZL6IBlYhDhqaW2K8qSQL0I2+furW7I5Lbh2PK3hX0=;
        b=PbIEWKI0Sv/XKJEkwotAj1EL5H9jtx/N00Bgy8z0g6bOqpm6Hx4eT8IV+KZOcz1jrP
         JPNEIsCUHjxk6CQRFWtMD1OSzbdKYwNarb/YEKkpsNKE8iJBaBCfYkozWyj90kArnIXa
         Iwi70IzVgXvDA88PiAiJ4najeB5TqWRKNIsHL1tGlZXsNQX6AMA0cPYnHMvZjc/9h37k
         LmI7bLWt/la1AlR9yGpYzGwoTaejkSFq8WqWppq5toeYmWhTBlaSTOuKX4zSjzmZj0Hp
         IDFRZGWVl2BI+Y4eotg6cvaCMbCHX4PpAU4wX70Bs8eQMSpISdlbA8IQLbJi84D9uas2
         en6Q==
X-Gm-Message-State: AOAM530ROsFMsw1S90FUlfwID3snHgVy3jWMgIHg4ZjWkqTPAxxeqERJ
        WbCPKFv2N/Hu/HJtPsm5Ui+zH4TeSW8=
X-Google-Smtp-Source: ABdhPJwbCws0Z/WNKTRiBChpksY1HsGbLyvEC0fJl7Bq1Ou35R9CY8r+0aanQJlnJtC6c3ctqsG4ww==
X-Received: by 2002:a5d:5388:: with SMTP id d8mr14276236wrv.423.1622315383131;
        Sat, 29 May 2021 12:09:43 -0700 (PDT)
Received: from [192.168.1.152] ([102.64.221.114])
        by smtp.gmail.com with ESMTPSA id b188sm6334254wmh.18.2021.05.29.12.09.38
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 29 May 2021 12:09:42 -0700 (PDT)
Message-ID: <60b29176.1c69fb81.2016b.8cc8@mx.google.com>
From:   Vanina curth <sanderlow01@gmail.com>
X-Google-Original-From: Vanina curth
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Hi,,
To:     Recipients <Vanina@vger.kernel.org>
Date:   Sat, 29 May 2021 19:09:31 +0000
Reply-To: curtisvani9008@gmail.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How are you? I'm Vanina. I picked interest in you and I would like to know =
more about you and establish relationship with you. i will wait for your re=
sponse. thank you.
