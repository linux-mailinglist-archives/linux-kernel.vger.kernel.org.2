Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66FD3FE3F5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 22:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhIAU0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 16:26:52 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:40879 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhIAU0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 16:26:51 -0400
Date:   Wed, 01 Sep 2021 20:24:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1630527892;
        bh=wvdyfuuvgWLif0GJRW36mFo+P+Mh6ICaw07RdRnThMg=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=FrOHTCIqt3I61txak4+8iO45X6EB6GXHWcTHEKdddUWY4TMJs3jk6y9iRunsikf29
         qxgUBzAuDs+6z/AtVYTrrAqGdbtnsRES5dYDjUhiK996OGbms/vNwaQlSS52QX762A
         c2Er8dhAynJU55dGgf/PsxJpqXGP9k614B8zUIWLD/q4M9FXwrOpQkIQqZGavRXAo7
         anAkGzcOPMk07mYhB6PotWuIQv3JlVbI7Kd/OzvykK1+nmRITr22gKri6oveI4bcTc
         upn39DNKvUZ1wyVU4qvWhjiwdu7HxcTna4lXh8vcpc+r03cU4Ws58Wk46GD9vAAvSm
         HUZPw/Q4fFM9g==
To:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: VKMS: New plane formats
Message-ID: <Qkd7rIf9j9Y-IlDoCbF8VB8T5sIKykTIuTfZIc1pCFPfvnfwIBGOMTnFo8i5jAWqGitlGEBH865MLF3C2jdIVk7TbRRFb_KVlte_FI0hjgI=@emersion.fr>
In-Reply-To: <d1ceaa32-e143-8d3c-4bfb-7b31673cc76c@gmail.com>
References: <d1ceaa32-e143-8d3c-4bfb-7b31673cc76c@gmail.com>
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

Ideally the final composition format would have enough precision for
all of the planes. I think it'd make sense to use ARGB16161616 if the
primary plane uses ARGB8888 and an overlay plane uses ARGB16161616.

To simplify the code, maybe it's fine to always use ARGB16161616 for
the output, and add getters which fetch an ARGB16161616 row for each
supported plane format.
