Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA32382215
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 01:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbhEPXWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 19:22:07 -0400
Received: from mail-40135.protonmail.ch ([185.70.40.135]:20809 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbhEPXWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 19:22:05 -0400
Date:   Sun, 16 May 2021 23:20:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1621207248;
        bh=o9NUnpWwWPmYQ+iKKyofsmuL+q/XvnMFtWtsza/uW30=;
        h=Date:From:Cc:Reply-To:Subject:From;
        b=bQpi9TG4ZMfr03jIujOUYkipkR4H2JvI/JsWnnbiLa2bmPy20REdDsKhlTjysb1ht
         l6PpZKe113wjw+n/om0YriBP3U083wQH9u2PITchSDW57K4a7LNaL61Y4eYYA6yp+N
         Wb4eZJlhKARyhfWWTREv2kQpkMU+mHl+uMNn5byw=
From:   louisrossberg <louisrossberg@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: louisrossberg <louisrossberg@protonmail.com>
Subject: Listening on a TCP socket from a Kernel Module
Message-ID: <5J_z4QNPMBAk4y0rGshI7mBykT1tivh3037CbQRYXTu_Ra6zuojEcI0RB04ghXQxgdtDbt3YFv6sA882mrFyTdzQePwHwvLoECnqFTnYNZI=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.4 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        MALFORMED_FREEMAIL,MISSING_HEADERS shortcircuit=no autolearn=disabled
        version=3.4.4
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, can somebody point me in the right direction for what I would use to=
 listen on a TCP socket from the kernel? I am working on a kernel module an=
d have spent the past day looking through include/net and include/linux for=
 something that would allow me to do so. I know TCP listening is typically =
done in userspace, but it should be possible at the kernel level right? tcp=
_diag looks promising, but it seems like that is mainly for monitoring sock=
ets, and I'm not sure if I would be able to provide responses from it.

Louis Rossberg,
Warped Technologies

