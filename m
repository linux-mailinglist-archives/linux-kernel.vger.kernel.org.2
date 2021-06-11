Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059453A4A14
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 22:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhFKUYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 16:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhFKUYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 16:24:17 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDBBC061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 13:22:19 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bp38so10384018lfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 13:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=FvqK8oV4w6JWOpETYVl5XjDW+0W7DLJvWrX9JFh/6Ic=;
        b=aSfTT5IIPzOIQx+1/h0lCxFBe/trQCMUQWetLP2lpM31TdOa8lph6tkD8GLqAo4Cmf
         wdOiUpFqFAn6Zn63Anbnlr/bm3oyh6v5m/CxO1cPFfB0oPSN7XU5Wohh2bol4ikrqnh1
         LqBQQUKXVSsajoPWV+d+3NnsJ5J4bCizc9UrZJrUD8i2HV9Ehe6ZTJ2cPDC28F8j7tAf
         e21XLY/fyah9RV+e5j15itltGKqrtuzQANmviYmfSqdJ4R4tvolbuE7vToVG7SnHo3CS
         +q5JSm70jCUDrYmcf/P4jHi7RGj2ettDSEo4HCIXrPj+S+1IlyBtyKk+9Juk+Z96P4gx
         Usrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=FvqK8oV4w6JWOpETYVl5XjDW+0W7DLJvWrX9JFh/6Ic=;
        b=N5lEcl654TfQMqpczG/r5w7YHNPQ7zH3aHE3c/AzIVwifBVJZrgwuK/deRLmQPV6Hs
         Vogu1YTTD/bDhldxLnb+LlgNSlaQ2NTcEgwbk/EHEhbjxKRvzjiJws0ff4dYY42beSMB
         8Jkjt4J0ZGdfgT0IL1LsWOxKJryz2w9KrdoiG1DKr1JxcLPp3rZkcv/9KfhrNVH4dejG
         M8hSfvKGP3ryOWECoA0pZ0KcTeqS4V4B+QhmC0kRg5SgWrfLvB+VXLuSpx5Vcz2W7rqn
         tvfJrBdYZ+jpsaJVRSiSndcNH/W6mkhhX4RABxJPpjl+t8jUy7B6zq8PZtfrUM9EKNLW
         cyqw==
X-Gm-Message-State: AOAM531ia4mwTSjCJUyctS9nTk3JVtHccLgLrfZ4pNd/R3wah8QyS3Sz
        Wpv7cLpq+zp6+s9uf2ibB5FMB25gZMIGK+1HMlM=
X-Google-Smtp-Source: ABdhPJxgo1DaSmnK+Qf4lKfrkf494ywSDB1RKdh4RIqXfGEiw44RGK7qeN47ud+sTuK9rRbMBxORagSuL0Q3C/TAViw=
X-Received: by 2002:a05:6512:1591:: with SMTP id bp17mr3694494lfb.20.1623442937737;
 Fri, 11 Jun 2021 13:22:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:25d2:b029:fa:3790:8a0d with HTTP; Fri, 11 Jun 2021
 13:22:16 -0700 (PDT)
Reply-To: sgtmanthey10@gmail.com
From:   Kayla manthey <shayelynnehaver77@gmail.com>
Date:   Fri, 11 Jun 2021 20:22:16 +0000
Message-ID: <CAGQwj4GymtcnzQUoYvOMDZSPC1BqBvbg5mYgP13+faiF17+TAA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Por favor, quiero saber si recibi=C3=B3 mis mensajes anteriores.
