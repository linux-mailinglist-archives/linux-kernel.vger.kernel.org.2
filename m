Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F023333E9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 04:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbhCJDmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 22:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhCJDl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 22:41:56 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98634C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 19:41:55 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id l22so5427541wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 19:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=D+gfigQyXMSup5UUt6cc3bhPGCuF8m9O3TKCUZXVnLY=;
        b=MB5ROXfKo6WntTEUHCsM/ul4MN9vUkql3cs9lovLx23771zr6/qHAQ2en/Q7/TVhLX
         1MqFIR+yGVVxuzrNhfDjWgF54EZLmFavSRzB7ghYf9LSwhlAkEmoZEoRgF3NebEUvpV4
         vJhpsq1JO/V/gMhApujW0Ef8ybMoqAWVB/7NV0scgdz2zs6U4IiK3pm56mc+JWp3BCwy
         NsGABpgMj748Hg1qQLHSOWLJpYDF7u04AAUIDW8TSJ0Qe+ws8qY0r/PTONQ+MNN0bTPv
         ffnwXrGviONELTOBJLz1a4bHGfdnuQkwcEsIgxYWW+3VBKjSIde2vewqfLnHlhfy8HrU
         VUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=D+gfigQyXMSup5UUt6cc3bhPGCuF8m9O3TKCUZXVnLY=;
        b=Vrm7R0pBs/tRUTx395o1He429/C89RS2QY+88v6RXcHciaberM7YjynmC6Y7VAvWyU
         BcXVi43zSETUtXAZV/CKp46HWV02wwhmXKevc1sYuxDTkxboC8mh+d2FfIb9MPCaOd8D
         bPEyXGteSK/OdGCOu6AkVeTwFxPquTFH4GCHtH6Qmniy3M2iT0v4tl3d7T9detb6ynp8
         aPdEv7ks9AZTWCGrGXIm3DFPT00XXeWHIugTjzpy/rTth6fWNxG7TscskyoP72lVm9jl
         OoeD2eGTM5/XeTb/JR4escoaJBYiKzsGIfI5D0wx0ycsJp1qLQT28klKRcG7UFPPN+39
         Xriw==
X-Gm-Message-State: AOAM530jryrjdqx6TvgDDEXVw/z7ZZLXubuVgaQVfAIzvEb4PZCZHi5n
        0GcnbZdF7K2LJKDvdVMOANZnsObnrqPFxg==
X-Google-Smtp-Source: ABdhPJxxKyzhOtp5FMrWjus2QW2s1uWHpOK3dZQ5a2u13PdgbOqBH0ihbhRsvyOrSFoKHHrBPM5uKg==
X-Received: by 2002:a1c:1f04:: with SMTP id f4mr1078130wmf.12.1615347714034;
        Tue, 09 Mar 2021 19:41:54 -0800 (PST)
Received: from [192.168.1.5] ([154.124.87.182])
        by smtp.gmail.com with ESMTPSA id a75sm7093491wme.10.2021.03.09.19.41.52
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 09 Mar 2021 19:41:53 -0800 (PST)
Message-ID: <60484001.1c69fb81.46340.1e10@mx.google.com>
From:   calantha camara <annabelleranson816@gmail.com>
X-Google-Original-From: calantha camara
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Hi Dear
To:     Recipients <calantha@vger.kernel.org>
Date:   Wed, 10 Mar 2021 03:41:51 +0000
Reply-To: calanthac20@gmail.com
X-Mailer: cdcaafe51be8cdb99a1c85906066cad3d0e60e273541515a58395093a7c4e1f0eefb01d7fc4e6278706e9fb8c4dad093c3263345202970888b6b4d817f9e998c032e7d59
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My name is Miss Calantha Camara, i was born on 22 -3 -1992,  never married,=
 l am from Somalia in Africa,

I'M presently staying in a refugee camp in Dakar Senegal as a result of the=
 political / religious crisis that has been causing problems in my country.=
 Because of this problem I lost my mother and my father during this deadly =
Political War. That Damaged Thousands of innocent Souls in my country Somal=
ia.

My Late father was a Successful businessman and also a politician supportin=
g the Present Government, During this problem  all the members of my family=
 were Murdered in a cold Blood and our family house was set blazed.

But I thank God I was in boarding school when this deadly incident took pla=
ce. It is only myself who is alive  but i don't have a home right now, I ma=
naged to make my way to another country Senegal where I am staying now and =
never pray to go back to my country  Somalia Again.

Please, I have a reason why I contacted you but before that i would like to=
 know about you what you are doing presently. I will tell you more about my=
self and the reason why I contacted you in my next mail.
