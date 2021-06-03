Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803CD39ABF5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 22:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhFCUu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 16:50:59 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:12910 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCUu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 16:50:58 -0400
Date:   Thu, 03 Jun 2021 20:49:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail3; t=1622753351;
        bh=h+xqUPyPmpZqgGOARjxUKlsGR88oIfRjRW+RtwkTUcY=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=tAS/QGasrvotYj4fDb6t+BWp0SS4Dd0mftmIZ99S5FOL/iM17azAr4ruKXBCqlXPI
         jQM3qZXzZ+ZnUqMtUhBR9pPGsRARApsXAdKqP1ua7Pjv0lO3grxMejuHM+1mcH4A5A
         izRd10W0L4MhPt3MqV0IuKp5zUXvqv2yUzoEFSDjEz85mikZxnvOrfUZLKaDJX8nNF
         JwO574ZeefcTTDwwdo6MFO2U55w7Bq7HX6C4GXuzEQj9yBeT3JFNG8DjrCqb+src9u
         Ow7ErQjL/2xcFrJ23/VT+pdfjuzIbNn1APNpZop5qhpspZsYk67E55tpmeqMnPeuSy
         6m4CfRA4wEJJg==
To:     Ming Lin <mlin@kernel.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Herrmann <dh.herrmann@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Greg Kroah-Hartman <greg@kroah.com>,
        "tytso@mit.edu" <tytso@mit.edu>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: Sealed memfd & no-fault mmap
Message-ID: <IGhZyUzuyCCNa4ps92NEd37xL_9W5DZnA9lyO9FGO5sxo5U2hxrgcPhQWY_HB0guIjYotTWILfa6VwXOz2SVY7bOf2rz89gpdNdXAxKeshA=@emersion.fr>
In-Reply-To: <ca7afd0e-4fea-4601-6c06-36e0e3664945@kernel.org>
References: <vs1Us2sm4qmfvLOqNat0-r16GyfmWzqUzQ4KHbXJwEcjhzeoQ4sBTxx7QXDG9B6zk5AeT7FsNb3CSr94LaKy6Novh1fbbw8D_BBxYsbPLms=@emersion.fr> <CAHk-=whSGS=R8PtrfNcDTkCKOengEqygqeWjOZa2b8QkuOueDg@mail.gmail.com> <alpine.LSU.2.11.2105291315330.25425@eggly.anvils> <36fc2485-11f1-5252-904d-f26b63a6cd58@gmail.com> <e7454046-c071-888d-f673-276f9c24d9d3@gmail.com> <CAHk-=whce3vmj+g7jcE0rasoDavJutxno3ZZrvvWYQywWXH31Q@mail.gmail.com> <0464f8dd-d082-b246-83ff-609f0f48de59@gmail.com> <8By7yERxX_qlsLZuOeJihJqeU-pZtFxsS2zrQ1ssN6-NkyIRrv-r81Ux_PTcb8qy7QA1HmkRxTeixT5MaJs7NKk0rqxDC9Nu9DoTRmS0UHw=@emersion.fr> <ca7afd0e-4fea-4601-6c06-36e0e3664945@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, June 3rd, 2021 at 10:07 PM, Ming Lin <mlin@kernel.org> wrote:

> In the new version of the patches, MAP_NOSIGBUS is not restricted to shme=
m.
> It can be used on ordinary files.

Oh, cool!

FWIW, if I had to choose between "MAP_NOSIGBUS not restricted to shm"
and "MAP_NOSIGBUS not restricted to MAP_PRIVATE", I'd probably choose
the latter. But of course the former is better than nothing at all.
