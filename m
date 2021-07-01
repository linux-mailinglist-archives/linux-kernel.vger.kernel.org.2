Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50DA3B91F5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 15:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236629AbhGAND5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 09:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236614AbhGANDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 09:03:14 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847A7C0613A3;
        Thu,  1 Jul 2021 06:00:42 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id yy20so10262124ejb.6;
        Thu, 01 Jul 2021 06:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DaPUpeGq4S3Zxelp1iJnw2sl2vB3LeguXSMXQNFZYHM=;
        b=rhIz2OrWRKxx/a+2VkK9ig3LnQCF7LQXVySbjUv8Tg6gNS0I4aIvQOzCSEyYgaZb4u
         YAYu/GPDCdpRaiQLtYQt5rz0kW4tf8JVYJo3LN8BXGNuQAIzuKdCmWshN56S9LwXguVz
         YspgpuH7e8ZaM4g7DckGHTqp1DCIGeQJDQEniLGRqxZWvbD1k+JC8cIMCYI872EJ/Odw
         EAZDjMw+UR3GoDBZTf0U/VVjdEEFvqL9W9gXKk2dhWK4vVniJqxK+MPpf+yYmW6oNUB4
         9qojbls90/gqdbIfySZruC2Bk5JfnON22bIsCvVeEAFepc8VSZxxtLfAWEJus0psMhl9
         z08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DaPUpeGq4S3Zxelp1iJnw2sl2vB3LeguXSMXQNFZYHM=;
        b=CBiZwYI6zdp4/AnFYPsRysf7bBiF447JWaPQ41JjQQ+JWxS1YHz4XbePrPfINuuh2M
         KT0s/yJ7JhE3uK8lvJbAcgKiMjVA36xM6ubBsUZZbA+umc1Pbgs+bZXyU53HUcPwssR9
         aeTSO1SGKX8lRzmGXvle+tV1bAFEXfkflKx4IyOxE2u7TS75DW2yG0HDFxFEIf8Jop0e
         5g5eOjP1rIPyHNmZqPujg5lH7j0OJx85Q4v5rlIcOOkg+twB0bOuRwW6Djvu0WTHR4+t
         7wes/4Eoe1L4L6C4tmznWHQK/8NclVX8roWilpsX4G7xU/MWQPZuhAIWCwm9Q3CyxKty
         ohsQ==
X-Gm-Message-State: AOAM531/i+UFDz4avVQ4Sna7R95iJ6PqVurHms8VL/XQYdKgRRBKDvnM
        VuinFKyISjtNCweG5jloAOKtm7rizNktPKXfj6M=
X-Google-Smtp-Source: ABdhPJzM3yEoovZnwfVb1Qa1kPEwNFYhhKiuEdFzc3Sy5RSkQBbOJ6ZPP9WgO14NEHXiTrQNvMot4A0DR9NplaDpDNw=
X-Received: by 2002:a17:906:2844:: with SMTP id s4mr40598906ejc.263.1625144441012;
 Thu, 01 Jul 2021 06:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210629022556.3985106-1-sunnanyong@huawei.com>
In-Reply-To: <20210629022556.3985106-1-sunnanyong@huawei.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Thu, 1 Jul 2021 22:00:28 +0900
Message-ID: <CAKFNMokmN5fZZ5_SUABYGOzEyd+sr3jYtfZNWmUTZwQAZa4NFg@mail.gmail.com>
Subject: Re: [PATCH 0/6] nilfs2: fix incorrect usage of kobject
To:     Nanyong Sun <sunnanyong@huawei.com>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, wangkefeng.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Nanyong

Thank you so much for sending this patchset.  I will review each and
send them upstream if applicable as is.

Thanks,
Ryusuke Konishi

On Tue, Jun 29, 2021 at 10:54 AM Nanyong Sun <sunnanyong@huawei.com> wrote:
>
> This patchset fix the memory leak problems and NULL pointer problem
> caused by incorrect usage of kobject in nilfs2 sysfs driver.
>
> Nanyong Sun (6):
>   nilfs2: fix memory leak in nilfs_sysfs_create_device_group
>   nilfs2: fix NULL pointer in nilfs_##name##_attr_release
>   nilfs2: fix memory leak in nilfs_sysfs_create_##name##_group
>   nilfs2: fix memory leak in nilfs_sysfs_delete_##name##_group
>   nilfs2: fix memory leak in nilfs_sysfs_create_snapshot_group
>   nilfs2: fix memory leak in nilfs_sysfs_delete_snapshot_group
>
>  fs/nilfs2/sysfs.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
>
> --
> 2.18.0.huawei.25
>
