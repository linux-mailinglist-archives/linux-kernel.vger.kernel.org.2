Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F493502D2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 16:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbhCaOyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 10:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbhCaOyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 10:54:32 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9782BC061574;
        Wed, 31 Mar 2021 07:54:31 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v11so19945261wro.7;
        Wed, 31 Mar 2021 07:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=of762KLdyKsIQqSd6i1lAmoFoTluBPZFqOpLx9cdtrY=;
        b=P4jU5Y0OQ7MUhJz8OyDH8VWu140oTsJskx+oiiISlbzm9x3UBhYWbjn7bO/W0e+xGC
         y4VTGyJiTSssjR7dPbVA72LWJ3ODdRFGT1Vjub1zaa8gLsvi7vSlyFYSOQNrz0Ni0p0f
         vCSRynz8IlIosY9+uIzYBvqGWWXS/ZSoGD3lQUvlJax5f1V56geenize6Dqb+OloqADi
         XSyHQu1ZWfeDmzWq567OutmE/3oqAFoy/knOQEHnX17pn3A1e36EpehQlN08VohdLqIu
         KYN7TxnPXsAqQMZpIzmQW65ghAugXM8b4mXfJmP5yNpk30WyxoLU1UclgLlmVCLK5DXk
         QcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=of762KLdyKsIQqSd6i1lAmoFoTluBPZFqOpLx9cdtrY=;
        b=iVEkqc74x2uiQn0GoMLXkm3FB8B0wiFh9mA0fM+yfg3ZVfR0HT7wXiPkN7I/nhpoXC
         K5GAgsLgPN4/2iCQdSodmAS62xpR+zZZxK6GQ57aRE12SgLNlUSCCL/sbt8+qHb/55Yj
         IjjjD2koxpw7ww87tw6IFLjwYpfLStOVmH2oIbbO+k/rzFNHGDQFIqcBo9Fz2GJ1av3H
         fD2UOmCbQrEJz5LFUC5ZYSoyWHvbnh1se3ssIgtP+jYU8C9USZ4MOzxWyFETBEXaNIkU
         cdqWpxe1tl1sASRYcFrXgjWSlVMEteqgAX29pB8sH8N3OcN4ZUx34T9va9+aXUIa6cEZ
         3aew==
X-Gm-Message-State: AOAM531C1uIqhZldtJm1CI9E0gl6iBwwgZSDyoyUyLpO11/UAo/COStT
        hS0r1MOnV4h4iCJ8TzzqGso=
X-Google-Smtp-Source: ABdhPJwwreQkfZoVT22Czn6fjPGmf2K6xDdIPmJ7GVdUBKwkmGq4jZIr9LZc1/qWMDIL/1hrnF9IbQ==
X-Received: by 2002:a05:6000:1ce:: with SMTP id t14mr4123634wrx.85.1617202469823;
        Wed, 31 Mar 2021 07:54:29 -0700 (PDT)
Received: from [192.168.1.5] ([154.124.19.111])
        by smtp.gmail.com with ESMTPSA id h10sm5048435wrp.22.2021.03.31.07.54.27
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 31 Mar 2021 07:54:29 -0700 (PDT)
Message-ID: <60648d25.1c69fb81.9b70d.a1cc@mx.google.com>
From:   calanta camara <mamadoucamara0452@gmail.com>
X-Google-Original-From: calanta camara
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: 
To:     Recipients <calanta@vger.kernel.org>
Date:   Wed, 31 Mar 2021 14:54:24 +0000
Reply-To: calanthacamara202@gmail.com
X-Mailer: cdcaafe51be8cdb99a1c85906066cad3d0e60e273541515a58395093a7c4e1f0eefb01d7fc4e6278706e9fb8c4dad093c3263345202970888b6b4d817f9e998c032e7d59
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

my name is calantha camara i want to talk to you
