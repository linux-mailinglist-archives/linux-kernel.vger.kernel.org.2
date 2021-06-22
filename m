Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D933B0BED
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 19:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbhFVR7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 13:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhFVR7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 13:59:05 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA16C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:56:48 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id i5so7433558eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=QSD81DruHkn8K7QzcU1rgYpPC1VfVIfS22gyJVAiA+I=;
        b=pDxEhRyfIUmuwWB+4BxEFw2yTk2XNKZAD47ULYduFjEXW/SFYPb97EaPiT/zEuRDou
         59NGJea21h+v0Zpvqp/RIWyuZl5V6GFBTbREePZpybYNaWJ4SpQk+QLd+kioficMP3m+
         pFNqdqTpqysPXeRuyoG3ojvrpbRVd+1R3SIR3OeCbGw3peiepbCGC0rcg69ROmWWgoqT
         fofl0qkyihzEcf3eY5DcrK/Yot0XvuFLtRzctd5MDkEXU6S5Ki82fT1ZSozTk17AEIIS
         P/m9GCV67/2pHnNNzcMQ/fXjahOTqCyDBBiyNY6rPb969J5RkSQH9zVPNYiV19pOtqQz
         ZVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=QSD81DruHkn8K7QzcU1rgYpPC1VfVIfS22gyJVAiA+I=;
        b=KuMWZyQ+ULA3mxlkXjs/QMYlBcMtwx0gclJMgqFSSQ3Q8FxQZnO+6jpqtUzcsLVe7X
         5Ivz++IPZ2s9vNmMWFbgANvBPi1VQ/m900HwNX2cmzfpVRxy1QN5PV+EHFVC2g7TmK+4
         sO9UP3m/C42nKbbW+t2w++oU2eRWGKiBY42Aa6MeyzKxYuZhNbFIIINAsqfbeu2HXSFL
         vjQvnvlY4kxRJiI3QufAKpC8LA/+iHSA/f3fCz6tffRrDB8gOA8rdzLZGue1owAjF9jE
         plpNEaGYf193qZTp81HGtyz1vgHexMQIVp8h51kGSED+p1Hji5iUeZYENkGCxCvzt0ZV
         NohQ==
X-Gm-Message-State: AOAM532gD02b0PwH0U7Swe7xREztdgI9nBJoAnMiYB8EaVVJv8ROkqiI
        BqK510oZNH4njGMTYXTOAuxMXJp7nbLniOfd868=
X-Google-Smtp-Source: ABdhPJxjIq/t6sZbCq9FnYxMLzq5YA6yHKEhIb7e4QYypd8CiE7ph0iFH6HrTIPnsUXVsoAyWOd9KXmZfynhZePAFpg=
X-Received: by 2002:aa7:dccb:: with SMTP id w11mr6670598edu.96.1624384607174;
 Tue, 22 Jun 2021 10:56:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6402:34c1:0:0:0:0 with HTTP; Tue, 22 Jun 2021 10:56:46
 -0700 (PDT)
Reply-To: alexandermorganmorgan238@gmail.com
From:   alexander morgan <marinavanessa534@gmail.com>
Date:   Tue, 22 Jun 2021 10:56:46 -0700
Message-ID: <CAAPyjrv59nz9bfWtQDnT289dWUDUa8QCatyuYdRnkoopWLL4hA@mail.gmail.com>
Subject: hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

7JWI64WV7ZWY7IS47JqULA0KDQoNCiDslYjsoITtlZjquLgg67CU652864KY7JqUPw0KDQoNCg0K
IOygnCDsnbTsoIQg66mU7Iuc7KeA66W8IOuwm+yVmOyKteuLiOq5jD8NCg0KDQog7Lmc7KCI7ZWY
6rKMIOyVjOugpOyjvOyEuOyalC4NCg0KDQog6rCQ7IKsDQo=
