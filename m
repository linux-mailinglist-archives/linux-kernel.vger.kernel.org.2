Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87462342657
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 20:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhCSTh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 15:37:29 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:62655 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhCSThN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 15:37:13 -0400
Date:   Fri, 19 Mar 2021 19:37:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1616182631; bh=0gYqyiW16TyPFK3ZonOwm02JDX0IoTuaJ9gN7oAEEjg=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=njnK3kee2zxOBQsk/q48Iy69hl9x5BxFySMzs788I+WjbpLz2bOy9qAiEQlvCpxcO
         24768umobEF04tcoWrllUa3001a21fmFqX+sCZ+vYpD3WRmau412VZEI1qhkMHlMTG
         ZRd6DGEnqVnQOYoR+b2WFMVP8+MNP8KxgM/Tro0FB39UftPmyPaC0jC9zSWXSAgyI3
         0Ykff8SXjUVbnusyCwxdkrTLuT5CcEqmi8URjhvypm5k9Ro+Bbdd/z5MoyV5GDxEiv
         qo1s2jGpVUJNGxJDNRt92sHBhi1CmBDbhA8+3ii3Hipwv4tSC/m3IlFbfVd5cKQ5BW
         56MlYanqKZ8sg==
To:     Masahiro Yamada <masahiroy@kernel.org>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Alexander Lobakin <alobakin@pm.me>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH RESEND 0/2] kconfig: fence choices and menuconfigs with comments in .config too
Message-ID: <20210319193705.267922-1-alobakin@pm.me>
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

Comment blocks for menus are great for dotconfig readability, but
currently it's the only type (beside plain comments) of submenus
for which these block are generated.
This series expands the code to also generate such blocks for choices
and menuconfigs and additionally expands the comments themselves a
bit to let know if they belong to choice or menu{,config} block.

Alexander Lobakin (2):
  kconfig: fence choices and menuconfigs with comments in .config too
  kconfig: mention submenu type in comment blocks in .config

 scripts/kconfig/confdata.c | 43 +++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 14 deletions(-)

--
2.31.0


