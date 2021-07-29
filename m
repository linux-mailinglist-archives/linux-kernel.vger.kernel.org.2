Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE203DABC1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 21:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhG2TVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 15:21:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26480 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229606AbhG2TVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 15:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627586473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bbi3e3he60RiuUGGMSO9VXfHUkHWKRL5IulkRfQYiGc=;
        b=cWHZA75i8Rj9JWtLZyL14Yy9PclJcVdVJzknfcJO8/DCAF/3Gc3LZzn2vhuZQ38zYmPoMU
        CpjRnD4F0H8uGEkpxAHTDM2f1m9FKf70+nqH6zW4KLzLW8FDjLGELUzs1YJw3NLjsF6t93
        a7AVAEZBWxW2XTVAzQaDo6LpKDlmc/E=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-DNMq_51bM-C_ZIyIVtLvqQ-1; Thu, 29 Jul 2021 15:21:10 -0400
X-MC-Unique: DNMq_51bM-C_ZIyIVtLvqQ-1
Received: by mail-io1-f69.google.com with SMTP id i10-20020a5e850a0000b029053ee90daa50so4436978ioj.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 12:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bbi3e3he60RiuUGGMSO9VXfHUkHWKRL5IulkRfQYiGc=;
        b=sYY1Zj4OJqXVee6/WlPOH6kimPwG9DUl2Y8viPDyB1BzJdO6faYF+IViG/T0zk6nSr
         zHmvLQo87bOImqjkpfzMZ163k17rlbN9wxmECyqsb8R85bsBHc9vjORyoH1N6VDQqbwn
         gjZr+pvjVCyW6dGr+VEW2QtyMzbG09LC0HxZTke1y03nsx6dE9lz1Oaq/M59wi/2lO+a
         vzw5drIn0h19q9rI7B9xWnCd0pWilxnpKNFz6ajyWfjPpeV/VvenLxvNCGIY4RJPa+1b
         o+YKEmQEI7S4LZ4RS6FLlOMdam8r1Yv8sjGZ7TySTnXJQ4V5W49iYG4iUr5wTHkkftZf
         wmpg==
X-Gm-Message-State: AOAM532CiVej34rbab0lsXyzIFY+Qy6MRYW506Wrbd8MjZddKSX3xFis
        jcVEJumAOe3Rp+pqQSq4Csi9AFDzerwcwN41BdWMp4D7DNqg/0Yd5cL9G98LtoqhMsQwmFBrCHc
        pFmX8c3lvQb6WarVjTfSr8O7+Oh5/1A2RxksxJ5+R
X-Received: by 2002:a92:cec5:: with SMTP id z5mr4491194ilq.226.1627586469740;
        Thu, 29 Jul 2021 12:21:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOuQC+UO8jwrToghqrOxaVwYt0H/hgmEJH6fXw8UUq2yKjcvEnl6h9LWqvIArjFChiUoIMvKUieVweDInY/mQ=
X-Received: by 2002:a92:cec5:: with SMTP id z5mr4491181ilq.226.1627586469553;
 Thu, 29 Jul 2021 12:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210729135250.32212-1-mlombard@redhat.com> <YQLfU4gzvAJYvBmx@fedora>
In-Reply-To: <YQLfU4gzvAJYvBmx@fedora>
From:   Maurizio Lombardi <mlombard@redhat.com>
Date:   Thu, 29 Jul 2021 21:20:58 +0200
Message-ID: <CAFL455k-wObZ_tZk_OzmLnbP-9+Ay34ExKwg8h971DDZrk-JyQ@mail.gmail.com>
Subject: Re: [PATCH V3] iscsi_ibft: fix crash due to KASLR physical memory remapping
To:     Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc:     Mike Rapoport <rppt@kernel.org>, bp@alien8.de, tglx@linutronix.de,
        x86@kernel.org, Peter Jones <pjones@redhat.com>, konrad@kernel.org,
        George Kennedy <george.kennedy@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C4=8Dt 29. 7. 2021 v 19:03 odes=C3=ADlatel Konrad Rzeszutek Wilk
<konrad@darnok.org> napsal:
> One part that I think you are saying but just want to double-check is
> that the isa_bus_to_virt() virtual addresses it returns - those are
> different every boot when KASLR is enabled, right?
>

Yes.
If KASLR is disabled, the physical memory is mapped at virtual base
address 0xffff888000000000 (on AMD64);
if enabled, KASLR will randomize it.

Maurizio

