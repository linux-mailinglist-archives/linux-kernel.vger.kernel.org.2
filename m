Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A1330695F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 02:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhA1BFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 20:05:15 -0500
Received: from mail-40136.protonmail.ch ([185.70.40.136]:57917 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbhA1BCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 20:02:21 -0500
Date:   Thu, 28 Jan 2021 01:01:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1611795682;
        bh=oN3yS61gBPJ9xdHSwY1nQqpqd4e0ESFLymvcdmGZwp0=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=oE963L2Oh2GbfTyYnc+jswD84Z7wFbj1K4D4c5axtEZt1VdZXOV+BYEsrmnT5EUxY
         Dfw85b5AKNIrTAmCFw05l0c2NPf3ZM78H+3LseuTp7qCpTRKj2dckjle5Sha1KI2vy
         Sm6zaX3l1n9+sbGEsf2lq70ZzW69CF8khFpSfoVc=
To:     Jonathan Corbet <corbet@lwn.net>
From:   =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@protonmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Reply-To: =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
          <nfraprado@protonmail.com>
Subject: [PATCH 0/2] docs: Add support for relative paths in automarkup
Message-ID: <20210128010028.58541-1-nfraprado@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Jon previously noted [1], it would be nice if automarkup supported relat=
ive
paths as well when cross-referencing to other documents. This adds the supp=
ort
for it, and documents it.

Jon, after applying this, 43bc3ed73639 ("docs: dt: Use full path to enable
cross-reference") could be reverted without the link stopping to work.

[1] https://lore.kernel.org/linux-doc/20201130142404.6ef6689e@lwn.net/

N=C3=ADcolas F. R. A. Prado (2):
  docs: Enable usage of relative paths to docs on automarkup
  docs: Document cross-referencing using relative path

 Documentation/doc-guide/sphinx.rst | 30 ++++++++++++++++++++----------
 Documentation/sphinx/automarkup.py |  7 +++++--
 2 files changed, 25 insertions(+), 12 deletions(-)

--=20
2.30.0


