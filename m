Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C6F3B76EA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 19:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbhF2RLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 13:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbhF2RLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 13:11:46 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3104C061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 10:09:19 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id q23so6235140oiw.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 10:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :to;
        bh=WOwqFHqZXMDqY29KpHZ5LvNqozS9WsiaH2cQ6GpbWpQ=;
        b=aG/VA5PmOWxSZy41UaViTrS4VxACKzcrectWxJTC7GhkNb4yZTYCe8HfJocFffqgHN
         TUra3znOXkyHU8lk4YX3FLrjvHtYPRNW+TESQfgITrtmpF07nNpmm83MaCWi3fF6S52H
         Ruab7nmNgs2l2NsYkTGsbZFENG4bM6F3iq5hEpPAAFSqkZt9szyc40ix5SV6brwPNd8v
         gxbfNjaroYqOx+7Jm6jrDN+ic+mSN+Pv4HoVvAvRukjPqQ3RNVZXoIThrJL0E6IyqvHU
         kK5ZNqzc4aQMRh9fmenpSLH2P4K93zl08WON7gR7k8anXWgrLCeXTYldgRUmAh+pVU9J
         Xw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:to;
        bh=WOwqFHqZXMDqY29KpHZ5LvNqozS9WsiaH2cQ6GpbWpQ=;
        b=gDgUzYuDn8g8czNuByrPWbDshdmgq+s6ZB0w5NMZ4Bza3FrfqRk5IAnSAokSYhgJ1V
         kDpsFn8M88YhO5ud3+0zKGKNZvW+HISRExGhjXz7fcdWsoZuFvdLos/K/JC8QEMk0IA/
         sI+0wJwTaNfIgvWf86sCpKZ+upOSbkMQ3dRBCtIOZZbR76dA0gWvvYmXYvKpCJEnHfTZ
         1Gpa5bXJ0qe4lj2Wx/z1PIh9jb/wZeGlTcSNi6QcjKUrPkXnjGEmYwzq5LzD210emwAF
         vpSDvLBBMaAfaRshxUJa2+a6I0V17usopSwqRwur9A1t4B+0swJDY5UWv3JcUXgCeOp1
         1Q4w==
X-Gm-Message-State: AOAM533DNwCDS9TuYbrLHDgbDi75ABforzcdoopzF9NXUi4JvH8MD4F4
        LYFaOlAlPsl82ynOtIJfUfaD+UP7HyjT0A==
X-Google-Smtp-Source: ABdhPJzt7aV/eDlyyEiztOVcElodQ5azNv08zeNclKoBzoAYFrAgUMOXs3x7RiMweYDSjErA2NUj2A==
X-Received: by 2002:aca:5b07:: with SMTP id p7mr22899088oib.118.1624986558932;
        Tue, 29 Jun 2021 10:09:18 -0700 (PDT)
Received: from smtpclient.apple (187.sub-174-198-157.myvzw.com. [174.198.157.187])
        by smtp.gmail.com with ESMTPSA id s28sm3995474oij.12.2021.06.29.10.09.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 10:09:18 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Mike <proclivis@gmail.com>
Mime-Version: 1.0 (1.0)
Date:   Tue, 29 Jun 2021 11:09:16 -0600
Subject: SMBus/PMBus terminology in spec will change
Message-Id: <3BE77907-0B7E-46F9-AAEA-7501358C883C@gmail.com>
To:     linux-kernel@vger.kernel.org
X-Mailer: iPhone Mail (18F72)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The PMBus technical committee is changing the master/slave terminology to co=
ntroller/target for SMBus and PMBus standards.

If anyone has questions or concerns about the upcoming changes, please let m=
e know.

Mike

Sent from my iPhone=
