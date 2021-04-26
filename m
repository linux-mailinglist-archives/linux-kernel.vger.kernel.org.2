Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F6836B4E1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 16:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbhDZOaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 10:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhDZOaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 10:30:52 -0400
Received: from office2.cesnet.cz (office2.cesnet.cz [IPv6:2001:718:1:101::144:244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C652EC061574;
        Mon, 26 Apr 2021 07:30:10 -0700 (PDT)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id 2FEF4400052;
        Mon, 26 Apr 2021 16:30:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2-2020; t=1619447408;
        bh=z/yOEdUwTqe7Cju7xA0JehEFyghVOswc8ZFTFwd6EF8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc;
        b=BBFw8yxGZmeaYREMBrgWlQ/H2dmC+msbVUjiW8NOu1UF24FRfMOibXYkIxFCeISY8
         2f8VnyzNS+K19xEv8bHbdlpKhsr0pNbULvoVZk2BYp1ulnlHuPtBDvlEhVTazm5JiA
         YsDp1TPylKpEUujN7ohPYbOV5Ibn6VSUXoQVRpLDerN1/NWIR0gzVPD7oN7W8nMSkc
         TJaosa/LEG33NAOJRzCvOo653L7+2GvX9noomOm76FiSPJxhrnacyExp9AUpjdwENe
         hr8OULEFNV9otSaW/8Ws5d2lyP4k9Em8h0g3FFy9gNbcZIOJZJ7fS0Qs8R/KtB7C6o
         QfSpPvR7/5DwQ==
Received: by mail-pj1-f43.google.com with SMTP id y22-20020a17090a8b16b0290150ae1a6d2bso5413038pjn.0;
        Mon, 26 Apr 2021 07:30:08 -0700 (PDT)
X-Gm-Message-State: AOAM530aUs0RN1IiBbh/ekkOFKmzfem96724IqoBdA5J/8HTggnrWQ6C
        trNpTWH0oxMB9xOO567H4yP5st8GF+Drex8l7TM=
X-Google-Smtp-Source: ABdhPJzY2F0vV+ycVTFKY+kJGuUUHc0GtcAB5VoEXe9hpIaYhT8MhH60TMGn4A5B+R9c7aRnoY63edVwF3++c6ja3Z4=
X-Received: by 2002:a17:902:b408:b029:ec:e879:bbd8 with SMTP id
 x8-20020a170902b408b02900ece879bbd8mr13449009plr.65.1619447406799; Mon, 26
 Apr 2021 07:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210413025948.901867-1-kubernat@cesnet.cz> <250c1c16-541a-984f-c720-1a8b6176e97e@roeck-us.net>
 <CABKa3npjrpq5Aw_Xqy3mFZtUHZcfB0YENxEDgo_MCwPUKqA4ww@mail.gmail.com> <20210426141745.GA257701@roeck-us.net>
In-Reply-To: <20210426141745.GA257701@roeck-us.net>
From:   =?UTF-8?B?VsOhY2xhdiBLdWJlcm7DoXQ=?= <kubernat@cesnet.cz>
Date:   Mon, 26 Apr 2021 16:29:55 +0200
X-Gmail-Original-Message-ID: <CABKa3np=osah3zcNmwohL0h8sVOHYcGW6rNYhM=1OzrOiLo50A@mail.gmail.com>
Message-ID: <CABKa3np=osah3zcNmwohL0h8sVOHYcGW6rNYhM=1OzrOiLo50A@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] hwmon: (max31790) Rework to use regmap
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

po 26. 4. 2021 v 16:18 odes=C3=ADlatel Guenter Roeck <linux@roeck-us.net> n=
apsal:
>
> On Mon, Apr 26, 2021 at 02:46:27PM +0200, V=C3=A1clav Kubern=C3=A1t wrote=
:
> > Hello.
> >
> > I'm sending a new version of my patch on max31790. This new version
> > fixes the cache issue and actually makes it work by setting
> > .cache_type. You were right about the "yes/no" ranges, so I flipped
> > those.
> >
> > By the way, it seems that the reason your reply got lost is because of
> > weird addresses in the "Cc:" email field, they end with "cesnet.cz",
> > so it could be that I'm sending email incorrectly. Let me know if I'm
> > doing something wrong.
> >
>
> Yes, the To: field of your series is either empty (for the first patch
> of the series), or it is something like:
>         To: unlisted-recipients: no To-header on input <;
>
> Also, you send your follow-up series as response of the previous series
> which doesn't follow the guidance for submitting patches and may result
> in the entire series getting lost.
>

Sorry, I will fix my email-sending procedure. Should I resend the
patch series without the In-Reply-To field?

V=C3=A1clav

> Guenter
