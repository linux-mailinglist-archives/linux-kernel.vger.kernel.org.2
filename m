Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDA041EE07
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 14:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353536AbhJANBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 09:01:39 -0400
Received: from smtprelay0083.hostedemail.com ([216.40.44.83]:59912 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1352814AbhJANBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 09:01:37 -0400
Received: from omf05.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 1EEB5182CED28;
        Fri,  1 Oct 2021 12:59:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id 11017B2797;
        Fri,  1 Oct 2021 12:59:51 +0000 (UTC)
Message-ID: <061762c85ea54ff7ebaaa1b2468f1c8c5cc84eb9.camel@perches.com>
Subject: Re: [PATCH] fs/9p: fix warnings found by checkpatch.pl
From:   Joe Perches <joe@perches.com>
To:     Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Date:   Fri, 01 Oct 2021 05:59:50 -0700
In-Reply-To: <20211001063444.102330-1-sohaib.amhmd@gmail.com>
References: <20211001063444.102330-1-sohaib.amhmd@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 11017B2797
X-Spam-Status: No, score=1.60
X-Stat-Signature: puwwxmhsexewzfpw3qbffo5mdcrmjsjr
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/T9D+S2TnbfTMVQ+IwfzVVUcKNC/yKCc4=
X-HE-Tag: 1633093191-702007
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-10-01 at 08:34 +0200, Sohaib Mohamed wrote:
> Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>

try using checkpatch on your proposed patch.

> diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
[]
> @@ -135,8 +135,8 @@ static inline struct fscache_cookie *v9fs_inode_cookie(struct v9fs_inode *v9inod
>  
> 
>  extern int v9fs_show_options(struct seq_file *m, struct dentry *root);
>  
> 
> -struct p9_fid *v9fs_session_init(struct v9fs_session_info *, const char *,
> -									char *);
> +struct p9_fid *v9fs_session_init(struct v9fs_session_info *v9ses, const char
> +		*dev_name, char *data);

That's really not pretty as it separates the type of the 2nd argument.

Perhaps:

struct p9_fid *v9fs_session_init(struct v9fs_session_info *v9ses,
				 const char *dev_name, char *data);


