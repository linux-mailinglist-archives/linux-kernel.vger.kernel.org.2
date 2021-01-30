Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051E430976D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 18:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhA3R6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 12:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhA3R6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 12:58:03 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10852C061573
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 09:57:14 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id m13so13824135oig.8
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 09:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tyhicks-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fi9b8nckj7fadbbwIBvSspDDslJwaNj4fD74sOu9ZAA=;
        b=w1El+5MymFdgHBc2MzkvbLT0ZdiJcE8FmuZoTzT8/HcbHzd/5bmT7hOcEzo7HLDUry
         9CimPDwEQal0ecwBtaFdp9tGqkMZlh8P8xIELUxQDZq8YrI+QJBbpuuhSGJbjUY3UwE6
         nFcc/vz1pchgE59tl/jlgx1v2DKVHSOWg5VKbwoz73wU+c5dxnQOiDu2xzB36E0aamG/
         ONX4yk3iMkTbNzTk3Rb/ceefrLnBhkDEuwRNs46ZoNzWnKnmuUC8Txf3lyQab50tDH8E
         nacjChzxSLa4X6xTuZGnoOAtPf37d6lud6rHzJYlrRCfJJuqmWtIApdqASDMuv5P/epw
         NHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fi9b8nckj7fadbbwIBvSspDDslJwaNj4fD74sOu9ZAA=;
        b=oQDx/JPDs6Gi+DLGu6O84iAH0K9Qccxz0+N0OjPlT0c2GArCn2Xs6jGtQRf8TJdi2G
         W8k0B6KnzSBynZoOXH/X9COy8TuJlASDi+eJRdzm6kisqJtfc7N//dGqp0YOdPbPs97f
         sxe94EaDTZ0ptEqdgGSrbjfzcCOUpPwK2s7ZJKA0aNHKrBczK9yB86eVdPhfgBaFOQt8
         pVEbLnSZgkk0iqjr865suUgnKZaoj0bUG5WqhZfm/ojPpFh7i4BKRqv3ijKfuJuEy3xL
         sRPqAwdVa9GQPq+5FlPcd1FzyBGkRoGoVmyrBPpshP67HUqEDApC2glEhxZax8AXtCs+
         odlw==
X-Gm-Message-State: AOAM533qkoK05TPGeBkVST9WxUd8CuBc+73wwe3AD09O5fMEzEJFnNpp
        gMINmNlJhvP4f22hx7TAmY6/7Q==
X-Google-Smtp-Source: ABdhPJz4dXFvNiMwBfQVvuV1r4yGCeptNQz+gVDG4xoq0tAnKDX0cs6lBMV71NX1EZPupsjas9OJ5A==
X-Received: by 2002:aca:eb0a:: with SMTP id j10mr6224338oih.4.1612029433451;
        Sat, 30 Jan 2021 09:57:13 -0800 (PST)
Received: from elm (162-237-133-238.lightspeed.rcsntx.sbcglobal.net. [162.237.133.238])
        by smtp.gmail.com with ESMTPSA id n28sm2854545otr.70.2021.01.30.09.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 09:57:13 -0800 (PST)
Date:   Sat, 30 Jan 2021 11:57:11 -0600
From:   Tyler Hicks <code@tyhicks.com>
To:     Joe Perches <joe@perches.com>
Cc:     trix@redhat.com, hannes@cmpxchg.org, mhocko@suse.com,
        longman@redhat.com, herbert@gondor.apana.org.au,
        ebiggers@google.com, ecryptfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eCryptfs: add a semicolon
Message-ID: <20210130175711.GB58096@elm>
References: <20201127160513.2619747-1-trix@redhat.com>
 <3168a3aa5c4ac564340cba2a151359e8cd3dee5f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3168a3aa5c4ac564340cba2a151359e8cd3dee5f.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-27 10:11:23, Joe Perches wrote:
> On Fri, 2020-11-27 at 08:05 -0800, trix@redhat.com wrote:
> > Function like macros should have a semicolon.
> []
> > diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
> []
> > @@ -1172,7 +1172,7 @@ decrypt_pki_encrypted_session_key(struct ecryptfs_auth_tok *auth_tok,
> >  	rc = ecryptfs_cipher_code_to_string(crypt_stat->cipher, cipher_code);
> >  	if (rc) {
> >  		ecryptfs_printk(KERN_ERR, "Cipher code [%d] is invalid\n",
> > -				cipher_code)
> > +				cipher_code);
> 
> As this is the only use that does not have a semicolon,
> it'd be good to add the removal of the semicolon from
> the #define at the same time.

I double checked that this is the only ecryptfs_printk() usage missing
the trailing semicolon and then made Joe's suggested change before
pushing the patch to the eCryptfs next branch:

 https://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git/log/?h=next

Thanks for the cleanup!

Tyler
