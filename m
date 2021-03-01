Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFE6327609
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 03:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhCACQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 21:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbhCACQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 21:16:24 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EF3C061756;
        Sun, 28 Feb 2021 18:15:43 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h98so14423826wrh.11;
        Sun, 28 Feb 2021 18:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=p197FIWEaE2McEUmDO7vulDyQknp7Y0aXGmXiZoR9gk=;
        b=jLRR1icqICKQsq+XZpogC7opN84/0i92ESwpne6yNIZC0SC35y2EfTeV2mgpE6u9I0
         4OtA81d07GV4pNYkbGT28lxW59QNF7Z18jmdCaPMm0FQVK+U16hpu0Us2+5pJz6JOZL8
         Ky5493qF0mFbg069mGFhGPlu6opp9kgXdp5XRWmkt0SZd8l7DSLm158BJvSzKuimmu28
         qN6NIECnZ+IGhR72MpapLBz0sxSCTVeG64HjijZ75pczBj8EcwVcrCH6YlP2zh7o2UXf
         7A/5l0oX9o/cFmIiaGdMN25SEp0DdZ+BLGhTAicMtSJAeFWnL5gBk+JhgJtu0yaqEQ7p
         Axiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=p197FIWEaE2McEUmDO7vulDyQknp7Y0aXGmXiZoR9gk=;
        b=O2jYjp+jmAokrHMKW8bZlcFYLADGmfurgMbrWxB+n8dmYVtnb6z5c7eFsO9tftWiCu
         2rgghDP1Jlg1UNPgkqYjftUzLW5trKuXDqkWplJu4JMbbFMbH8QkMJBX19d8UUiJluHZ
         /KNV/hVpEQMMybQcVi34rl6E49cjCWLgxqaOjtYoO7h/A2k/aThLYCecp6DwG7YwX4kN
         1miiCCYfqaYsC2upNh0cf2Gt9R4QpTE62gvNYjZZt0fkD1bwlddBinxc+c1fNP5qmhUa
         Z2ytG0cwW/eOn7H3OEccTwG7A6LALpR8EDpY7UmbcovXqeiCRICM67mh/j3DlB77tHCY
         IMTQ==
X-Gm-Message-State: AOAM531LHRB+1LZxZaHWlUPxszS3GcnCGe6VOT729QZttniJRsOOqeXZ
        Due/mo82tdOybXaer2gvXso=
X-Google-Smtp-Source: ABdhPJzwWmbsIJ7ZKuo+lg9CYdVq/bJlW06zI+kKbGMQW/y3AVVOQ+egxJpvP0DYc0v4rdi5BwL7Yg==
X-Received: by 2002:a5d:4743:: with SMTP id o3mr486957wrs.108.1614564942279;
        Sun, 28 Feb 2021 18:15:42 -0800 (PST)
Received: from [192.168.1.5] ([41.83.217.193])
        by smtp.gmail.com with ESMTPSA id f17sm23026870wru.31.2021.02.28.18.15.39
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 28 Feb 2021 18:15:41 -0800 (PST)
Message-ID: <603c4e4d.1c69fb81.5dc9a.152c@mx.google.com>
From:   Calantha Camara <amadouneymar794@gmail.com>
X-Google-Original-From: Calantha Camara
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Hi Dear
To:     Recipients <Calantha@vger.kernel.org>
Date:   Mon, 01 Mar 2021 02:15:37 +0000
Reply-To: calanthac20@gmail.com
X-Mailer: cdcaafe51be8cdb99a1c85906066cad3d0e60e273541515a58395093a7c4e1f0eefb01d7fc4e6278706e9fb8c4dad093c3263345202970888b6b4d817f9e998c032e7d59
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this is about me

My name is Miss Calantha Camara, i was born on 22 -- 3 -- 1992,  never marr=
ied, l am from Somalia in Africa, =


I'M presently residing in a refugee camp in Dakar Senegal as a result of th=
e political / religious crisis that has been causing problems in my country=
. Because of this problem I lost my mother and my father during this deadly=
 Political War. That Damaged Thousands of innocent Souls in my country Soma=
lia.

My Late father was a Successful businessman and also a politician supportin=
g the Present Government, During this problem  all the members of my family=
 were Murdered in a cold Blood and our family house was set blazed. =


But I thank God I was in boarding school when this deadly incident took pla=
ce. It is only myself who is alive  but i don't have a home right now, I ma=
naged to make my way to another country Senegal where I am staying now and =
never pray to go back to my country  Somalia Again.

Please, I have a reason why I contacted you but before that i would like to=
 know about you what you are doing presently. I will tell you more about my=
self and the reason why I contacted you in my next mail. =

thanks and God bless
yours calantha
