Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141803FF281
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 19:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347093AbhIBRjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 13:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346939AbhIBRjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:39:23 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B01EC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 10:38:25 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id w19-20020a17090aaf9300b00191e6d10a19so2012661pjq.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 10:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7us7Bc5u35eJaewwSdNGx9sRWC9woMDHBHe1rJ6Zg18=;
        b=AC6UxvqB2eXubCiB2UUp4DYdBHZhJAPteh4dFbXGWZFxgysViv6bDVc6sXm+oN7Bok
         K2jrHReLLewDc3bJvwt+th3ZSpqeT2PQvMUO7gzjWrka3fapKfiBJCbBQ5d4tUEyWHS1
         Lue/qUz2TVUuapOZKvNztKWVG1uFUSketrMlad1jUxV4etWKcbAuXZycOitnG1TJkVOu
         8mtCazCpHmWnMRyXI8E8MMUE4s0sXCfh4epSPgFHTZgd/KlSlEwmEIcEd6lusS/hfJ7O
         rLEfoXYtuRX2xpOHhZYDhzlacy03ny8h1RXlVWCUoOhKtwKRvhCb0aYRR3n39GeMLTUx
         zEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7us7Bc5u35eJaewwSdNGx9sRWC9woMDHBHe1rJ6Zg18=;
        b=bzUna0XutUiSXMHlYRwZYj0rCsbgSONY/2QJzVuYxSTYALO1GdlNmjL6iHg3gafUio
         LPkqwVPksmE1cXRuKxDZekneKnUxbhAiv73jA/j1TyfmKKqJwrNT5thiXGxZ7EwabW7d
         jaQhRJojbNKc5+7s5v+SVl0vbGGbEIxGCMgkzYm7MHe/WvYcOTyxjVmMFCZM6UfeeSMP
         xYbQWh9rufRvEp/uOz0FEU1pO7jH44kFD+Y/HSIiQK8lnXOhB5DzCblQyofscxXgHW5j
         25ZUQP8SxdmaVrueqHOuEFSXNBFsh0Gx7p8OOY9jDggFyZo0YfoEDaWxeaDvFBkNUbOX
         g3iQ==
X-Gm-Message-State: AOAM532o3EELEq3egSyY7vyB8fwE1fCxSZqlLzVmwNBjCdTt2cAfS71w
        eKFV7fYy6MoQhubCPIKL3Wk=
X-Google-Smtp-Source: ABdhPJzG85PbqyLoUxGfrjkcUz8vOBZE3THkN+oNMisSh1rZEPyvvqVtHcfG6fQXUtWVvMWAmdn2Hw==
X-Received: by 2002:a17:90b:3583:: with SMTP id mm3mr5122296pjb.75.1630604304670;
        Thu, 02 Sep 2021 10:38:24 -0700 (PDT)
Received: from devbox.home ([50.39.96.2])
        by smtp.gmail.com with ESMTPSA id v3sm2927409pjd.27.2021.09.02.10.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 10:38:23 -0700 (PDT)
Date:   Thu, 2 Sep 2021 10:35:55 -0700
From:   Pawan Gupta <writetopawan@gmail.com>
To:     Babu Moger <babu.moger@amd.com>
Cc:     bp@alien8.de, bsd@redhat.com, corbet@lwn.net, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org
Subject: Re: [v6 1/1] x86/bugs: Implement mitigation for Predictive Store
Message-ID: <20210902173555.egnq6c3kve6fnd4z@devbox.home>
References: <20210519055001.jtos5a4nu6j6kum2@devbox.home>
 <20210901203058.14598-1-babu.moger@amd.com>
 <3cda7690-1a26-5377-fbe1-41f047a4ff3a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <3cda7690-1a26-5377-fbe1-41f047a4ff3a@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.2021 15:35, Babu Moger wrote:
>
>
>On 9/1/21 3:30 PM, Babu Moger wrote:
>> Pawan, That is kind of odd. The ssb_mitigation enums are defined in bug.c. To be consistent it is better to keep it in nospec-branch.h as they are related.
>
>Sorry, I meant all these mitigations related enums are in nospec-branch.h.

Thats not true:

   $ grep "^enum.*{$" arch/x86/kernel/cpu/bugs.c
   enum taa_mitigations {
   enum srbds_mitigations {
   enum spectre_v1_mitigation {
   enum spectre_v2_mitigation_cmd {
   enum spectre_v2_user_cmd {
   enum ssb_mitigation_cmd {

>So, it better to keep it there for consistency.

But, I am not too adamant about it.

Thanks,
Pawan
