Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C930E402193
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 02:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237711AbhIGAJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 20:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236253AbhIGAJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 20:09:12 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404C4C061757
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 17:08:07 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mj9-20020a17090b368900b001965618d019so372863pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 17:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XqRu0z2Qhjs0mvuVTfdyLCxvW6UnsTdZLsaV7CaJajk=;
        b=THPVv3KV4fHAZh2jKOoVbmjvS6USvkg8tEoqpY5g9Ay7RDaDs8eVm3CzahyCyXiYCE
         dmioefCdKHamm8A6OzNKzXS5vWjfQQy+xE7Lwv5raZkRzyamp54HMrPnS0STdGg8bbQU
         Ucig9U2TvVdoi/I1y+jmnWbqFS1T4gJh6GDL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XqRu0z2Qhjs0mvuVTfdyLCxvW6UnsTdZLsaV7CaJajk=;
        b=ewMOrYOG5o8WjG9y1uKNrGyO033PWQBYHx25f1fYxuRRZHdvyv49S+WvOnqR756TME
         Vv6K9nFbAGf2gPkkrCZ/gsB4HxPpjT0qc+RNrIZxT3r4oal+s5SMGoVXKh88Ds44y6CL
         MnTof382ei4h6IPRA+C5oEYxIjagWLzaVcFeXERHz9PgAg4fwRrWSex/BbCCb1beQsZk
         uqOjSxOy3r3hkNMD1QcGYCvzbqOM5CTeZYiWpVhs/H58cdPv+TNhRRylhLTKFaMjI5RZ
         ZqEyu011LxJDrx1MOC3a19/vo8xR+9SmCjwYlDpIO8UMrLi8nHYV0LIWP4iMod5zVAB5
         7LCA==
X-Gm-Message-State: AOAM5332Q8EbdbU5qRtNTn0+HYUZjjpcpNw0sxwTbEObOCHdlji+7aHV
        Z0CnieGFa70w0vxG5WlWtaAu6A==
X-Google-Smtp-Source: ABdhPJygBpZDHO0khjmYw+va4z4BztjolHbfaxw2Uf52dv0IQawbfJU1o5SPyVNemqlLGCKhb1LIcg==
X-Received: by 2002:a17:902:7145:b0:137:2e25:5bf0 with SMTP id u5-20020a170902714500b001372e255bf0mr12564988plm.10.1630973286689;
        Mon, 06 Sep 2021 17:08:06 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:4040:44a5:1453:e72c])
        by smtp.gmail.com with ESMTPSA id 141sm11395031pgg.16.2021.09.06.17.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 17:08:06 -0700 (PDT)
Date:   Tue, 7 Sep 2021 09:08:01 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steve French <sfrench@samba.org>,
        Hyunchul Lee <hyc.lee@gmail.com>, linux-cifs@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ksmbd: add missing assignments to ret on
 ndr_read_int64 read calls
Message-ID: <YTatYScZNOYHxruf@google.com>
References: <20210906134438.14250-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210906134438.14250-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/09/06 14:44), Colin King wrote:
[..]
> @@ -275,11 +275,11 @@ int ndr_decode_dos_attr(struct ndr *n, struct xattr_dos_attrib *da)
>  		if (ret)
>  			return ret;
>  
> -		ndr_read_int64(n, NULL);
> +		ret = ndr_read_int64(n, NULL);
>  		if (ret)
>  			return ret;
>  
> -		ndr_read_int64(n, NULL);
> +		ret = ndr_read_int64(n, NULL);
>  		if (ret)
>  			return ret;

A pretty nice catch by that static analyzer tool.

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
