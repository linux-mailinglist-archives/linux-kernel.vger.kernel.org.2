Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361A43D6950
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 00:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbhGZVhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 17:37:42 -0400
Received: from mx.cjr.nz ([51.158.111.142]:6680 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232875AbhGZVhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 17:37:40 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Jul 2021 17:37:40 EDT
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id C47BF807A3;
        Mon, 26 Jul 2021 22:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1627337399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o3r8oVjRtR44tqw2N+dCH1FWPiJ5zilIyu6rtRHUiN4=;
        b=I4d0pnS5TB3gwxfBOzSC8kBue4AGu7EyasQpvYPmqtloykbJlaYfVrSv64b2Ov+4UfCntn
        6dWG9WOd/3L2VhbEzOtlqxpMSnTMKBpL21GH6zXIyCJw5L9osviOFciRIs2BR5TxA7iHjB
        ToPXdjD0bLrb+P2MgHVRUL26/IuIhXgTy5smskvBqVnvJ5T77GhlFP5ZBGoN5nYUABYVfy
        RbnTdkfxv2GeoUdjxExoLqPolSKEEZBr+CrNeAXJP0H+t3rnrW8uCi+ZCuPY4D1tGT4jNd
        JNuvCPZKgUrSFzbK2FurOV/qanFbMqEz3cGeeY+H/Zj87eTsMsMe3gRrPS0zlg==
From:   Paulo Alcantara <pc@cjr.nz>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        ronnie sahlberg <ronniesahlberg@gmail.com>
Subject: Re: [PATCH][SMB3] fix static analysis warning in
 smb3_simple_fallocate_write_range
In-Reply-To: <CAH2r5mv-HDPQ0XUTsH8e8xVJtfgcB12i=Yk1RiHZo2EJUOQHFQ@mail.gmail.com>
References: <CAH2r5mv-HDPQ0XUTsH8e8xVJtfgcB12i=Yk1RiHZo2EJUOQHFQ@mail.gmail.com>
Date:   Mon, 26 Jul 2021 19:09:54 -0300
Message-ID: <87r1fkn2vh.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steve French <smfrench@gmail.com> writes:

>     Clang detected a problem with rc possibly being unitialized
>     (when length is zero) in a recently added fallocate code path.
>
>     Reported-by: kernel test robot <lkp@intel.com>
>     Signed-off-by: Steve French <stfrench@microsoft.com>
>
> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
> index 23d6f4d71649..2dfd0d8297eb 100644
> --- a/fs/cifs/smb2ops.c
> +++ b/fs/cifs/smb2ops.c

Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
