Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F81A397C68
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 00:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbhFAWbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 18:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbhFAWbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 18:31:38 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A17BC061574;
        Tue,  1 Jun 2021 15:29:56 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3ADDB6E2;
        Tue,  1 Jun 2021 22:29:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3ADDB6E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1622586596; bh=y9sxAzj+dWrVwmKL8DGxCyxl0p5fDGQaBGnGuwpqGfo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=sJOtHjJwOq85gKYJk9beusRgOTjtW/UBduW9ZDIaQxVMj2pt0/IpQhNyOsmnuiJhM
         iiRq8qHrdqr2P8h8W5RFu4zfPg3NYhKiIjR4TT/r/jmlQkbH92UWdVMwJ4m8l2hun1
         6mrNUmtR7ClYUpps4pRaWoesNg2sLeY3ywkTJwxasK2JpCV5ungGJsvnM21nHPLnMb
         JSn8qrzXkEeX/2DpLWuOpNqTYLvWyTc0a7DDLVr2N8cMgvh7qnsksW9iDr6nbLSkAj
         5wqqNwRlJaAgXE4O1S5jxJxu16AQz/A7zkmPHxOLksaKMu8M7Q+gXwiijATQYBVDIC
         fGg2Qjekvkvdw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 0/2] Fix some issues at scripts/sphinx-pre-install
In-Reply-To: <cover.1621949137.git.mchehab+huawei@kernel.org>
References: <cover.1621949137.git.mchehab+huawei@kernel.org>
Date:   Tue, 01 Jun 2021 16:29:55 -0600
Message-ID: <87v96x8bh8.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Currently, when using with --no-virtualenv, the script doesn't behave well,
> as it prints both instructions to install Sphinx via distribution's package
> manager and via pip.
>
> Address it.
>
> While here, rework the logic which recommends Sphinx install, by
> splitting it into three parts and making easier to maintain it, as
> there are too much complexity there. Splitting the Sphinx part
> of the logic on 3 separate functions allow to detect if the venv/virtualenv
> python packages are needed or not, and helps to have a cleaner
> logic.
>
> Mauro Carvalho Chehab (2):
>   scripts: sphinx-pre-install: rework the sphinx install logic
>   scripts: sphinx-pre-install: fix the need of virtenv packages
>
>  scripts/sphinx-pre-install | 262 +++++++++++++++++++++++++------------
>  1 file changed, 180 insertions(+), 82 deletions(-)

I've applied this set, thanks.

jon
