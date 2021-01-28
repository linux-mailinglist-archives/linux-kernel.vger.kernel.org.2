Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959E130695D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 02:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhA1BFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 20:05:02 -0500
Received: from mail1.protonmail.ch ([185.70.40.18]:13893 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbhA1BCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 20:02:34 -0500
Date:   Thu, 28 Jan 2021 01:01:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1611795699;
        bh=JpHvdf4WlWJrwuqfau82dS6nFbc1g8Q6OZk5049t/is=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=tIvgqb/CKtYJzYMp0MVvjk+J93VS5UJxGzwCnutyRKWAVe63yUcsvZTyKnp3eUbwi
         ZFa0oNibp/5rqgxqey62dM0mkAmygyIVmeoNdyRYj3sDlIawnx5whxSJJB3eJ0e/qp
         Z2mDC1tPspo+Wp5jHJjw3kUeI/Htp6DvxJ2vir8s=
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
Subject: [PATCH 2/2] docs: Document cross-referencing using relative path
Message-ID: <20210128010028.58541-3-nfraprado@protonmail.com>
In-Reply-To: <20210128010028.58541-1-nfraprado@protonmail.com>
References: <20210128010028.58541-1-nfraprado@protonmail.com>
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

Update the Cross-referencing section to explain how to create a
cross-reference to a document using relative paths and with no
additional syntax, by relying on automarkup.py.

Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com>
---
 Documentation/doc-guide/sphinx.rst | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/s=
phinx.rst
index 36ac2166ad67..ec3e71f56009 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -340,16 +340,26 @@ Rendered as:
 Cross-referencing
 -----------------
=20
-Cross-referencing from one documentation page to another can be done by pa=
ssing
-the path to the file starting from the Documentation folder.
-For example, to cross-reference to this page (the .rst extension is option=
al)::
-
-    See Documentation/doc-guide/sphinx.rst.
-
-If you want to use a relative path, you need to use Sphinx's ``doc`` direc=
tive.
-For example, referencing this page from the same directory would be done a=
s::
-
-    See :doc:`sphinx`.
+Cross-referencing from one documentation page to another can be done simpl=
y by
+writing the path to the document file, no special syntax required. The pat=
h can
+be either absolute or relative. For absolute paths, start it with
+"Documentation/". For example, to cross-reference to this page, all the
+following are valid options, depending on the current document's directory=
 (note
+that the ``.rst`` extension is required)::
+
+    See Documentation/doc-guide/sphinx.rst. This always works.
+    Take a look at sphinx.rst, which is at this same directory.
+    Read ../sphinx.rst, which is one directory above.
+
+If you want the link to have a different rendered text other than the docu=
ment's
+title, you need to use Sphinx's ``doc`` role. For example::
+
+    See :doc:`my custom link text for document sphinx <sphinx>`.
+
+For most use cases, the former is preferred, as it is cleaner and more sui=
ted
+for people reading the source files. If you come across a ``:doc:`` usage =
that
+isn't adding any value, please feel free to convert it to just the documen=
t
+path.
=20
 For information on cross-referencing to kernel-doc functions or types, see
 Documentation/doc-guide/kernel-doc.rst.
--=20
2.30.0


