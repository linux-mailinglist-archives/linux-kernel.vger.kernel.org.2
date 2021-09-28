Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D1341A6CD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 06:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbhI1Ewa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 00:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhI1Ew3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 00:52:29 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70828C061604
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 21:50:50 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 17so19896715pgp.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 21:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M0Co+ALRufPDUwEQ8baD5b9ifUKrM4r2VVJwlHDINLo=;
        b=EFAONHjEgGTHC3pcF2kin9AidgHkPrjmbVNpOEJ0DiL4kz4BTcef0fX09E7RL3FGHr
         MCm+NUfVp//yBGLq6N01Hzlq6SLE0x8AjvM3MKeCKvHpz/zRPsK7CCRvq+zd7xDP0JAY
         76WGVb99fYev5KDD01nhEG5Ww7/Os+iJpp33g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M0Co+ALRufPDUwEQ8baD5b9ifUKrM4r2VVJwlHDINLo=;
        b=y7iQKf+K7ZYb/V4CqneXoLGdOOxhewFUZqQn7JjiorUEcKFXKlZjJhHP3hNf5mMxB1
         fO7NjB6zMsFRPsr/tpgKx7pB9DKj9TJTvpQI90Uj++U8QstVHIUMH2GJojF+BEqswYvI
         WGxZxMUs78npQnO8cGM09a9uOFLtWWhK/5aUVgqjC3+KXCOenHj1BXViZQUVybAFz8iL
         v0r8VHY1WuI6RAikkM+h3MsOeFw94wlwAlVw+RI/yyhGW0JZAQeSdsyXoqTjsj7uD8QF
         2xCdm5sfjDOD8RrluLznZpVdKKrCI5xgARauYCOoN3J8LJQeykzyOvmxd2GEnPHkLc0g
         tv/w==
X-Gm-Message-State: AOAM531U4sunhE8Vks2X84JdsZOriNrL1QXwcw201uF7qC6bRJHgqEXz
        lwJRZkmPhjVqAnAyisEHMir21w==
X-Google-Smtp-Source: ABdhPJxqZF6O912rcipwO2QbikBI51gYi5RSDiHU1jOcbTf9zbqbnhqXB2QWOc1mRocq+QyetRsUeQ==
X-Received: by 2002:a05:6a00:1a02:b0:446:d18c:8e7e with SMTP id g2-20020a056a001a0200b00446d18c8e7emr3638882pfv.46.1632804649827;
        Mon, 27 Sep 2021 21:50:49 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:481c:a10e:b908:28fe])
        by smtp.gmail.com with ESMTPSA id k190sm19613210pfd.211.2021.09.27.21.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 21:50:49 -0700 (PDT)
Date:   Tue, 28 Sep 2021 13:50:44 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv6 7/8] videobuf2: handle V4L2_MEMORY_FLAG_NON_COHERENT
 flag
Message-ID: <YVKfJMpdHXrwYYRn@google.com>
References: <20210909112430.61243-1-senozhatsky@chromium.org>
 <20210909112430.61243-8-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909112430.61243-8-senozhatsky@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/09/09 20:24), Sergey Senozhatsky wrote:
[..]
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 9b7032abb2c7..f118fe7a9f58 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -959,7 +959,8 @@ struct v4l2_requestbuffers {
>  	__u32			type;		/* enum v4l2_buf_type */
>  	__u32			memory;		/* enum v4l2_memory */
>  	__u32			capabilities;
> -	__u32			reserved[1];
> +	__u8			flags;
> +	__u8			reserved[3];
>  };

[..]

>  struct v4l2_create_buffers {
> @@ -2515,7 +2519,8 @@ struct v4l2_create_buffers {
>  	__u32			memory;
>  	struct v4l2_format	format;
>  	__u32			capabilities;
> -	__u32			reserved[7];
> +	__u32			flags;
> +	__u32			reserved[6];
>  };

These UAPI changes break strace compilation (older versions). Up until
Feb 2021 strace had compile time asserts that check-ed sizeof() ->reserved
fields.

  static_assert failed due to requirement
   '(sizeof (((struct v4l2_create_buffers *)0)->reserved)) >= (sizeof (((struct_v4l2_create_buffers *)0)->reserved))'
   "Unexpected struct v4l2_create_buffers.reserved size, please update the decoder"

It seems that strace has dropped those assertions

https://github.com/strace/strace/commit/e5554291d14b852f61385ba5ba59412d133ac99d#diff-d534423e8a79b6957ef4deb7f8bbd3276bf18ede6a82553e8823ee4f840b6e06


But we, probably, need to use unions in UAPI. Any thoughts?
