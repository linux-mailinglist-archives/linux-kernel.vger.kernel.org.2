Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A9C424B61
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 02:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240103AbhJGAwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 20:52:21 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38584 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbhJGAwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 20:52:20 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BC4A822595;
        Thu,  7 Oct 2021 00:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633567826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FkN4LgNhKj4PxuOMK7Hfo8inuz6SvPxGt6pScV3hnp4=;
        b=LXfORfH9wk5KIW+5fKfUkcT3af9vJ8rm2QMKXIy58BXB9UoeCcbfOX1fe16DI4ePLkL5i1
        4XICBaDBqqzX7LrSAJoWg1iYXmL3J+AShuZCkFtq86Dy4nJk8VvkW7Qwzz3seYey0JutzC
        XLJsWpXnVSxMkNy4QqiKlJfeKyfqmeo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633567826;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FkN4LgNhKj4PxuOMK7Hfo8inuz6SvPxGt6pScV3hnp4=;
        b=IDgCl56VFg5B6d1bpOw01J6TMqXakyoJC4bz4c84eCcZw/qU6tuthfuBkIhbxn6CQH6zJA
        4fl/2izlRwIvGTBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E368513A66;
        Thu,  7 Oct 2021 00:50:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TEIkKFBEXmGnAwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 07 Oct 2021 00:50:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Wei Yang" <richard.weiyang@gmail.com>
Cc:     kuba@kernel.org, gregkh@linuxfoundation.org, mojha@codeaurora.org,
        jkosina@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hashtable: remove a redundant check in hash_for_each_xxx()
In-reply-to: <20211007003058.uj35ekwibbrxqzku@master>
References: <20211006152100.17795-1-richard.weiyang@gmail.com>,
 <163355497171.31063.8329134032738647570@noble.neil.brown.name>,
 <20211007003058.uj35ekwibbrxqzku@master>
Date:   Thu, 07 Oct 2021 11:50:22 +1100
Message-id: <163356782206.31063.3710696596883334978@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Oct 2021, Wei Yang wrote:
>=20
> Here is a draft patch based on you comment:
>=20
> diff --git a/include/linux/hashtable.h b/include/linux/hashtable.h
> index f6c666730b8c..2ff4cb5e6a22 100644
> --- a/include/linux/hashtable.h
> +++ b/include/linux/hashtable.h
> @@ -116,6 +116,13 @@ static inline void hash_del_rcu(struct hlist_node *nod=
e)
>  	hlist_del_init_rcu(node);
>  }
> =20
> +/**
> + * Note: the following three hash_for_each[_xxx] helpers introduce a new l=
oop
> + * command that is constructed from 2 nested loops. It is safe to 'break' =
out
> + * of this loop even though it is a two nested loops.  The 'obj =3D=3D NUL=
L' test
> + * ensures that when the inner loop is broken, the outer loop will break t=
oo.
> + */
> +
>  /**
>   * hash_for_each - iterate over a hashtable
>   * @name: hashtable to iterate
>=20
>=20
> If you feel good, I would like to add=20
>=20
> Sugguested-by: NeilBrown <neilb@suse.de>

That's definitely an improvement.

I'd probably put it in the kernel-doc comment for hash_for_each,
then in the other two just put the "it is safe" bit.  Something like
the following.  But I don't feel strongly about it.
I'm happy to say
  Reviewed-by: NeilBrown <neilb@suse.de>

for your patch.

Thanks,
NeilBrown


diff --git a/include/linux/hashtable.h b/include/linux/hashtable.h
index f6c666730b8c..61db940c9501 100644
--- a/include/linux/hashtable.h
+++ b/include/linux/hashtable.h
@@ -122,6 +122,10 @@ static inline void hash_del_rcu(struct hlist_node *node)
  * @bkt: integer to use as bucket loop cursor
  * @obj: the type * to use as a loop cursor for each entry
  * @member: the name of the hlist_node within the struct
+ *
+ * Note: It is safe to 'break' out of this loop even though it is a two
+ * nested loops.  The 'obj =3D=3D NULL' test ensures that when the inner loop
+ * is broken, the outer loop will break too.
  */
 #define hash_for_each(name, bkt, obj, member)				\
 	for ((bkt) =3D 0, obj =3D NULL; obj =3D=3D NULL && (bkt) < HASH_SIZE(name);\
@@ -134,6 +138,8 @@ static inline void hash_del_rcu(struct hlist_node *node)
  * @bkt: integer to use as bucket loop cursor
  * @obj: the type * to use as a loop cursor for each entry
  * @member: the name of the hlist_node within the struct
+ *
+ * It is safe to 'break' out of this loop.
  */
 #define hash_for_each_rcu(name, bkt, obj, member)			\
 	for ((bkt) =3D 0, obj =3D NULL; obj =3D=3D NULL && (bkt) < HASH_SIZE(name);\
@@ -148,6 +154,8 @@ static inline void hash_del_rcu(struct hlist_node *node)
  * @tmp: a &struct hlist_node used for temporary storage
  * @obj: the type * to use as a loop cursor for each entry
  * @member: the name of the hlist_node within the struct
+ *
+ * It is safe to 'break' out of this loop.
  */
 #define hash_for_each_safe(name, bkt, tmp, obj, member)			\
 	for ((bkt) =3D 0, obj =3D NULL; obj =3D=3D NULL && (bkt) < HASH_SIZE(name);\

