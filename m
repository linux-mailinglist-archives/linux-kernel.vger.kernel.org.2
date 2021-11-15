Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF13A45120A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 20:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbhKOTY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 14:24:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47584 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238942AbhKORuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 12:50:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636998476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YGf+XUfSwydKiiv0hT0cmfPV/U4WfCIrm4XgycOeKw8=;
        b=KS56kO6+jwT+7mO7bbWHIHUHgzgKeRR1h/v3D15zFfbuXVcqILEX9FMEfXX84DoJsYU85l
        z0PsI3VCilBgWnu1Hf0VSC/3Xgg5rwiUTsaxklsfameAFF5DxI1NJmuCQZFy3N9oL9RyzI
        T2nZ1a+6vca/9S5O5d9RDd1Euyz0uis=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-u1ML8PLjOnW51WcQd4gadw-1; Mon, 15 Nov 2021 12:47:54 -0500
X-MC-Unique: u1ML8PLjOnW51WcQd4gadw-1
Received: by mail-wr1-f71.google.com with SMTP id d3-20020adfa343000000b0018ed6dd4629so3810490wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:47:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YGf+XUfSwydKiiv0hT0cmfPV/U4WfCIrm4XgycOeKw8=;
        b=RKO7muMCjOGW0K/QA6kxF6n/Q1mZGu53ILEGs3/Qd3wZse2FgPw7IOQ3ykMkPK26/1
         0UT3p5oH/qrYk5Jgm0L4d8wyu0TlbnOJE/eXSvYcOe9qIfSaFyL4drdkMRYiwMtd/A5T
         8WGFjrj+kP6vjJKBMzFVivAGVRNMfvzMfZLQcLJKTHcwIpFpPqz/7Nzhtrg2qQeKH+yc
         HGvVf1gqeYoUO8dYbiknLvB7arkzvrC+McZpnaGu0EYt1FL2l9NQIt+4HdqON3X6h2I5
         JQ/b9tqugoXgacIIgmJ4OdpTbB1QW9CY69qZk8osksKJq4CowEz4Q5nEwHWYHOy88M05
         Boeg==
X-Gm-Message-State: AOAM5316unh/bHp1TaOKO03zh6ArVU1XlrjcKfZ1B+eav50cvJrqX5hq
        99QP+F04G+0Vl5UvIIjtn4IomY7oJNQbri389QL62nP12ucB0fBgk/RblcuYaUuC8LRWGJnaUO8
        VS2+Swwl9xgkWlj/cyANU2QYNt7vSGwCq81XJH0ZB
X-Received: by 2002:a05:600c:1ca0:: with SMTP id k32mr371687wms.74.1636998473248;
        Mon, 15 Nov 2021 09:47:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzqKzOEnvwu+fh1qgttyP6hSbaWqXIBdsUkNrLY9BsgCe2smG8I38SVxWF2PmLje6pNL9tmSfjVvcdJ16iCWZI=
X-Received: by 2002:a05:600c:1ca0:: with SMTP id k32mr371664wms.74.1636998473021;
 Mon, 15 Nov 2021 09:47:53 -0800 (PST)
MIME-Version: 1.0
References: <20211115165313.549179499@linuxfoundation.org> <20211115165315.847107930@linuxfoundation.org>
In-Reply-To: <20211115165315.847107930@linuxfoundation.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 15 Nov 2021 18:47:41 +0100
Message-ID: <CAHc6FU7a+gTDCZMCE6gOH1EDUW5SghPbQbsbeVtdg4tV1VdGxg@mail.gmail.com>
Subject: Re: [PATCH 5.4 063/355] powerpc/kvm: Fix kvm_use_magic_page
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

On Mon, Nov 15, 2021 at 6:10 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> From: Andreas Gruenbacher <agruenba@redhat.com>
>
> commit 0c8eb2884a42d992c7726539328b7d3568f22143 upstream.
>
> When switching from __get_user to fault_in_pages_readable, commit
> 9f9eae5ce717 broke kvm_use_magic_page: like __get_user,
> fault_in_pages_readable returns 0 on success.

I've not heard back from the maintainers about this patch so far, so
it would probably be safer to leave it out of stable for now.

Thanks,
Andreas

> Fixes: 9f9eae5ce717 ("powerpc/kvm: Prefer fault_in_pages_readable function")
> Cc: stable@vger.kernel.org # v4.18+
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/powerpc/kernel/kvm.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/arch/powerpc/kernel/kvm.c
> +++ b/arch/powerpc/kernel/kvm.c
> @@ -669,7 +669,7 @@ static void __init kvm_use_magic_page(vo
>         on_each_cpu(kvm_map_magic_page, &features, 1);
>
>         /* Quick self-test to see if the mapping works */
> -       if (!fault_in_pages_readable((const char *)KVM_MAGIC_PAGE, sizeof(u32))) {
> +       if (fault_in_pages_readable((const char *)KVM_MAGIC_PAGE, sizeof(u32))) {
>                 kvm_patching_worked = false;
>                 return;
>         }
>
>

