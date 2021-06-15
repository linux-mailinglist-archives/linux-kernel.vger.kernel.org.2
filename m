Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290083A8904
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 20:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhFOTAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 15:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhFOTAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 15:00:33 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD05C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 11:58:27 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id d2so101320ljj.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 11:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1l+TgcrG/jdNtGh4+CRzkkljCRvQxHjsEK+JJYiByBA=;
        b=LeOtkEe2qCTRiSUbmrVYGdezN28DWEjzRKVMpSKPUoMKO5sarME9uuvGA+Xu/4fZab
         6sUPm17bdDXupF8j34YgPJZC7dl6pnQCAvWTO8ZY3CI/IqfcMDaeTlF/sznaqGuKaV20
         Z25w2/CyVTKmjCufViJQceIjwLuoSgvtpvtn8dGNH/ULl1m7aC1OOpCjFcKD1iPzzfG4
         f9niEENYEuJIL9ZkOAr9bbMa6Zrbr7EqDYAy0dc2hcaJebR7dz03mgZISznGNywX3Gol
         q6kYk/yB999ezNN5WS1Bgyps4S20EwdwCAf3Iy0HoL8SgLfPbYw+hROCIcPKhLpsE4YG
         UspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1l+TgcrG/jdNtGh4+CRzkkljCRvQxHjsEK+JJYiByBA=;
        b=cpjfjEoXWJ+RPYBAOpAuRm9rLip8rruHl3jX0HswkdMg5EAbkguaFJaq7rheqsUPAb
         OdW/9tNL2FBe7rbaZVIWiLEjPlRfEu5nmRlwVGgEVWzAQz62XZ3TT5zj6l96pJmyH0/X
         zTCZ49Zin0YdB8nsbsZu6Ik1LYKNVmkp9h0aC2FVID+XnLiviNVcnNPVrsKh+R43Su88
         K8Nvwbp6zZkfqocmqwlpEq+xxNNaYPCUSEQQKctbFkFoEjU19HOdm01/Q8LxGNrSw/uj
         g4Lub6QPJL63Es+fk/LzbKvu307J+KFuARkkFm82PT07BQ5egJmhId0xGKXmsEpQx22g
         FNNA==
X-Gm-Message-State: AOAM533AItEVMEHjXIafMnrtzn4DmBPXmOxsB114EjlgPvAS852EukNt
        d3loqy15ijbs7LMt+UE0NIJ5ZaNSmqmhZ35SLRs=
X-Google-Smtp-Source: ABdhPJyvP6iSzbvLqJWGeB7GRLHfxxsakEjiSQpqQ9BOexXX6dWfUu+K+giVos/YlN8xnIPOuq34vhLExwFhtILZPlc=
X-Received: by 2002:a05:651c:288:: with SMTP id b8mr932295ljo.482.1623783506171;
 Tue, 15 Jun 2021 11:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210615185206.7701-1-paul@pbarker.dev>
In-Reply-To: <20210615185206.7701-1-paul@pbarker.dev>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Wed, 16 Jun 2021 00:28:14 +0530
Message-ID: <CABJPP5Ch4oTnrVZxSO3qLXO2M0xawLJpBO-T5+L7EJDRH3s1Hg@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: Use python3 to run spdxcheck.py
To:     Paul Barker <paul@pbarker.dev>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 12:22 AM Paul Barker <paul@pbarker.dev> wrote:
>
> Since commit d0259c42abff ("spdxcheck.py: Use Python 3"), the shebang
> line in scripts/spdxcheck.py says the script should run with `python3`.
> However, checkpatch has been explicitly running this script with
> `python` so it needs updating to ensure that Python 3 is used on all
> distros.
>
> Signed-off-by: Paul Barker <paul@pbarker.dev>
> ---
>  scripts/checkpatch.pl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 23697a6b1eaa..5e5e3a53461b 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1084,10 +1084,10 @@ sub is_maintained_obsolete {
>  sub is_SPDX_License_valid {
>         my ($license) = @_;
>
> -       return 1 if (!$tree || which("python") eq "" || !(-e "$root/scripts/spdxcheck.py") || !(-e "$gitroot"));
> +       return 1 if (!$tree || which("python3") eq "" || !(-e "$root/scripts/spdxcheck.py") || !(-e "$gitroot"));
>
>         my $root_path = abs_path($root);
> -       my $status = `cd "$root_path"; echo "$license" | python scripts/spdxcheck.py -`;
> +       my $status = `cd "$root_path"; echo "$license" | python3 scripts/spdxcheck.py -`;
>         return 0 if ($status ne "");
>         return 1;
>  }
> --

Hello,
This change was already added by Commit c739ec2da1ea
("checkpatch: scripts/spdxcheck.py now requires python3")
in linux-next.

Thanks,
Dwaipayan.
