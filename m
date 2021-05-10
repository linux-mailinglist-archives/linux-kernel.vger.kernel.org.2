Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581B4379A60
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 00:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhEJWtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 18:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhEJWtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 18:49:35 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D752FC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 15:48:29 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id t4so26973068ejo.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 15:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YJHukdhsz2R5XGvodf4K0HCj8ed5JNJ4TIuOxOAr6u8=;
        b=Uvf9szO4Hdhhn8UAwzjT97j7lNwOicqItbif8JcYaIRxSbna7FHJL/t6jGKKQeJj66
         9W0XlOmf/apXcav3C3oZiSgLrbwmqR8MhycTfmjAvlQMZB6o9ghgdst2bBdjP0inobOT
         1STlhPwhbnEJITnZWP/R66o90hub7DSbwM8pT3/Ohv4DgohvX8jYJ5P08alqbFNob7df
         wp713IQsnFPW/nrYleyGwtWLMEs7WtfDvlDl3qKXd1rtgnUIarGe9p5leTnt/S8AgUPF
         WIdfvrHi4+cXtvEwuE7Jyks103oTZwUsK2ZRWpd2fCaknYNSD6JgvnHz0C83O0435Rye
         qBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YJHukdhsz2R5XGvodf4K0HCj8ed5JNJ4TIuOxOAr6u8=;
        b=kDpquB15O+jI6S79/g7deRmIbqTQME1ukGxgMfNmK6jO2MvchhjugBi49BJHTQD4f7
         nTlUvxhL/9tf3+dtb7/mV9JWQkzCW4PcvJI/pUXWGfFd1ZpNmIV3fA5EcWN/702lgrEe
         MbBRCnRt4jwXiOcbSjxZDSGfsE8oS7m8Jc50EVbq/59EzXwQjrHpKKB1yClYne4i9vpx
         j20HNPZtDNSK3Kv4UiVbpe4+WzEaj22794tAR45Z5HsDOvAj7G8UgSAVA7DOwZ0LDOas
         KcI6RPGGVglPyVuxvm1gXsURwVzt8gLUqUHcc+NQSQNM12qNkhhXunCHAYTpjzrn60Tc
         TZBQ==
X-Gm-Message-State: AOAM532exqz1Z6Q5yy+SBAbpweD5gokCW1tQdKcpDczr1ALNrElgtU9q
        m6PINsAt+oXD6gkiaZ54cOBeaF9nay1RFUSQ5R4GJJUdtA==
X-Google-Smtp-Source: ABdhPJzgdlrX7gX2KnDE1PTWs5652eCIfz19L2ILlevRe7jywoMQEf0eRd9hPje5FbLIRT58/D/Ayild11nCjlAXMWk=
X-Received: by 2002:a17:906:134c:: with SMTP id x12mr859446ejb.178.1620686907520;
 Mon, 10 May 2021 15:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210509183319.20298-1-michael.weiss@aisec.fraunhofer.de>
In-Reply-To: <20210509183319.20298-1-michael.weiss@aisec.fraunhofer.de>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 May 2021 18:48:16 -0400
Message-ID: <CAHC9VhRkh3uySjZ1qg07Fgky+R3jSmfJ80BLCFOK+LCPvZVrOA@mail.gmail.com>
Subject: Re: [PATCH] audit: allow logging of user events in non-initial namespace.
To:     =?UTF-8?Q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 9, 2021 at 2:33 PM Michael Wei=C3=9F
<michael.weiss@aisec.fraunhofer.de> wrote:
>
> Audit subsystem was disabled in total for user namespaces other than
> the initial namespace.
>
> If audit is enabled by kernel command line or audtid in initial namespace=
,
> it is now possible to allow at least logging of userspace applications
> inside of non-initial namespaces if CAP_AUDIT_WRITE in the corresponding
> namespace is held.
>
> This allows logging of, e.g., PAM or opensshd inside user namespaced
> system containers.
>
> Signed-off-by: Michael Wei=C3=9F <michael.weiss@aisec.fraunhofer.de>
> ---
>  kernel/audit.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

I think this needs to wait on the audit container ID patchset to land.

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 121d37e700a6..b5cc0669c3d7 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1012,7 +1012,13 @@ static int audit_netlink_ok(struct sk_buff *skb, u=
16 msg_type)
>          * userspace will reject all logins.  This should be removed when=
 we
>          * support non init namespaces!!
>          */
> -       if (current_user_ns() !=3D &init_user_ns)
> +       /*
> +        * If audit is enabled by kernel command line or audtid in the in=
itial
> +        * namespace allow at least logging of userspace applications ins=
ide of
> +        * non-initial namespaces according to CAP_AUDIT_WRITE is held in=
 the
> +        * corresponding namespace.
> +        */
> +       if ((current_user_ns() !=3D &init_user_ns) && !audit_enabled)
>                 return -ECONNREFUSED;
>
>         switch (msg_type) {
> @@ -1043,7 +1049,7 @@ static int audit_netlink_ok(struct sk_buff *skb, u1=
6 msg_type)
>         case AUDIT_USER:
>         case AUDIT_FIRST_USER_MSG ... AUDIT_LAST_USER_MSG:
>         case AUDIT_FIRST_USER_MSG2 ... AUDIT_LAST_USER_MSG2:
> -               if (!netlink_capable(skb, CAP_AUDIT_WRITE))
> +               if (!netlink_ns_capable(skb, current_user_ns(), CAP_AUDIT=
_WRITE))
>                         err =3D -EPERM;
>                 break;
>         default:  /* bad msg */
> --
> 2.20.1

--=20
paul moore
www.paul-moore.com
