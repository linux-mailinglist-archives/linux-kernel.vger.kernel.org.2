Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71442382965
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236336AbhEQKHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbhEQKGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:06:53 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB04C061573;
        Mon, 17 May 2021 03:04:12 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id i4so7790880ybe.2;
        Mon, 17 May 2021 03:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qIKmhM7At+cvDCjzfFjeWVSkq9swk8WtNWhGEBBaDcQ=;
        b=Ajb68P7G9lNl8YaCytpUave8ILnuiZaqE6jKx5vtto8RT/LO91+Egu6aUHUIETJ4ld
         IfgTsBufk0Lcbr2/kQKUpIiqqveIYnfvsOhI+f2WxqNzghc3WQO1pOiJ9omz3V4UMJY/
         YcAia0VAtzAPcuWbm2R+7MBzSpBROvlQlRqIZUb7LC+TPRIYOjsKYLi/98/DA8UEmK2Q
         Ta5UZPci9QaSFHFwLRpBWs7mH9reDqXhiS+HdBaRC7aoDCGtHhgFUv3LY6ZwV0cOqer1
         lMyt6myxj/rGq7V2l3Vv2a+6ucyOMgFcIdSuBwctZaDXauM/V0+qj4F3UMZexdbtBLWZ
         FX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qIKmhM7At+cvDCjzfFjeWVSkq9swk8WtNWhGEBBaDcQ=;
        b=aMUaV3NVYuYHjz5I/dcgk66ERupmqp8Jo9wI/KWB5QMp/0mYG7aBnZNFRWgls/ukG7
         KatLJGhmD3T63J/WwhzvRLIlTkW1hMuXEpl923JWunHrtnoFmLBScIf0yK6yvp/d9n5o
         F5XYpw3UpxElgDJfNILjo8y20bEJ+SykZ28kNsmtwnmDNv177z7OoCOrIHCTg7CqMSGg
         wAnhFqZSoe+j4YVfrncP2lBI4Om4CLau3pVDdBAnV+ttgL9O/hTm3sHht5GJoU5OMvW6
         GoCw7TMK4sWXJenwe2uNdCsFGGWkOgpKLz9e7ByOcFtBioKggmXiJzZGbJ0gooND2gES
         Uwzg==
X-Gm-Message-State: AOAM531tGhoFHBSRK30mZxr2EjxP5eyKgZKBXB52+Cos/JMmlj1BrmrP
        4d5FupUbuo4mPT81rtu17Axg6a2NPDP2wAfWvJ1dJOsL
X-Google-Smtp-Source: ABdhPJxjQ8N3x83GMxBAzddjATIlukmYbFTwRKIeVy+0WeEJd9XXjSfkjlWoqFoitNU8+ap/rJGoPfVedLvcEzQkL2o=
X-Received: by 2002:a25:e006:: with SMTP id x6mr84151466ybg.151.1621245851350;
 Mon, 17 May 2021 03:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210515132348.19082-1-dwaipayanray1@gmail.com>
In-Reply-To: <20210515132348.19082-1-dwaipayanray1@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 17 May 2021 12:04:14 +0200
Message-ID: <CAKXUXMyDPj4yLLLjPoWELDuWr4rvbU9MPvcp+vGqyzrFNGrQKQ@mail.gmail.com>
Subject: Re: [PATCH] docs: Add more message type documentations for checkpatch
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2021 at 3:24 PM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
>
> - Document a couple of more checkpatch message types.
> - Add a blank line before all `See:` lines to improve the
>   rst output.
> - Create a new subsection `Permissions` and move a few types
>   to it.
>
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>

Dwaipayan, thanks for all the good work on this documentation:

Acked-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Lukas
