Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0B3425D1F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 22:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241022AbhJGUWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 16:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbhJGUWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 16:22:24 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B453C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 13:20:30 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id t16so5856417eds.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 13:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=leZcGtTng3eevV63OAKUACR68M+9QewnJIsvQT/Auj0=;
        b=dnBA7brfe/Qx/pQnrW+x73PG5o6W5fm3WCRcHhNojBmZA3HVrakvvkzqkyW1/7vS8q
         1FCZJGe25MhCcenhxLNJO0yeRrvG6PR9W5aZhPorkXpziTdt7nwH6bEdRUupVBlI/9jb
         6cbcDTC/8zEVOBUEr8cqNARCp1PiAfav2lyOgZygHgV4AGR3yAwm2/8KEkyaSzSKUOKZ
         EexedP2NgX2veQ2xwVw7N3BnCp3DsCfLVidtJj2YhrSsFuCA6NrNmYGxKF1A2eYCGpXw
         X/2Hns1QKYscVkmpyJZrO/jxhdH/epOsaDItCSUTZ+YnICmlUC/QJxjF4vn0ZykOfSgD
         r8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=leZcGtTng3eevV63OAKUACR68M+9QewnJIsvQT/Auj0=;
        b=j9unB0YSZxkbVLi7j26bTr05lAEAifv+WlhMuwrlTyOfyi8RqaHJO6n+X8UR5wiSDR
         jlKYmnXhe9M+el2Y2tLhKCJdZSfjCbzhZFc+obMNvseiO+ZXXWc+jQfJB205jrHpB5Lx
         +6MJG2kY6l/W4tKAxbG923gl6FpaRVkohxxgel5lA1Yz+iK4BFLov2NWNwxpwx8263AM
         0M2XzB8y5Bs5kjPYkjuylv3mmrSKAfAdqZ2NCmJ9ArmQp914S4tx5MKxpiePGw4CA2Bh
         1PhFo2JwXWCCIdBGUWWyysBZXpIPBOcQUy7BSGoyqQxwHZN+qZlszwfICNahP/wFcilT
         Su2w==
X-Gm-Message-State: AOAM533Z+iIYjw9xPgsGuXe2lgulyfwKmAAvILZrKLOtGg9iQMSziDlx
        WSR/AIh5v4kO3L4s0byERv73NrAZ8wJsCqyGoRUJ
X-Google-Smtp-Source: ABdhPJylmF5ayZFx1lznVzMCAtuE0bU+kdLIQgZW0D7msY6VSLkzi3rpjS1JVj7uxqBNQO+q8cK1SXQOfPtXpuvt/Gw=
X-Received: by 2002:a17:906:2f16:: with SMTP id v22mr7932610eji.126.1633638028725;
 Thu, 07 Oct 2021 13:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211007115653.133463cb@canb.auug.org.au>
In-Reply-To: <20211007115653.133463cb@canb.auug.org.au>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 7 Oct 2021 16:20:17 -0400
Message-ID: <CAHC9VhS6CDkW41a6kuQ55r7CNjUvYNNGmQbD+W1=xa=ko=u-7w@mail.gmail.com>
Subject: Re: linux-next: manual merge of the selinux tree with the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 8:57 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the selinux tree got a conflict in:
>
>   fs/io_uring.c
>
> between commit:
>
>   3d2b8972f292 ("io_uring: optimise plugging")
>
> from the block tree and commit:
>
>   5bd2182d58e9 ("audit,io_uring,io-wq: add some basic audit support to io_uring")
>
> from the selinux tree.

It looks like some of the conflict is also due to cdc1404a4046
("lsm,io_uring: add LSM hooks to io_uring") but based on a quick look
the fixup seems correct.

Thanks Stephen.

> diff --cc fs/io_uring.c
> index 73135c5c6168,f89d00af3a67..000000000000
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@@ -903,8 -917,10 +905,10 @@@ struct io_op_def
>         unsigned                buffer_select : 1;
>         /* do prep async if is going to be punted */
>         unsigned                needs_async_setup : 1;
>  -      /* should block plug */
>  -      unsigned                plug : 1;
>  +      /* opcode is not supported by this kernel */
>  +      unsigned                not_supported : 1;
> +       /* skip auditing */
> +       unsigned                audit_skip : 1;
>         /* size of async data needed, if any */
>         unsigned short          async_size;
>   };
> @@@ -6542,9 -6622,12 +6576,12 @@@ static int io_issue_sqe(struct io_kioc
>         const struct cred *creds = NULL;
>         int ret;
>
>  -      if ((req->flags & REQ_F_CREDS) && req->creds != current_cred())
>  +      if (unlikely((req->flags & REQ_F_CREDS) && req->creds != current_cred()))
>                 creds = override_creds(req->creds);
>
> +       if (!io_op_defs[req->opcode].audit_skip)
> +               audit_uring_entry(req->opcode);
> +
>         switch (req->opcode) {
>         case IORING_OP_NOP:
>                 ret = io_nop(req, issue_flags);
> @@@ -7042,10 -7071,34 +7082,15 @@@ static int io_init_req(struct io_ring_c
>                 if (!req->creds)
>                         return -EINVAL;
>                 get_cred(req->creds);
> +               ret = security_uring_override_creds(req->creds);
> +               if (ret) {
> +                       put_cred(req->creds);
> +                       return ret;
> +               }
>                 req->flags |= REQ_F_CREDS;
>         }
>  -      state = &ctx->submit_state;
>  -
>  -      /*
>  -       * Plug now if we have more than 1 IO left after this, and the target
>  -       * is potentially a read/write to block based storage.
>  -       */
>  -      if (!state->plug_started && state->ios_left > 1 &&
>  -          io_op_defs[req->opcode].plug) {
>  -              blk_start_plug(&state->plug);
>  -              state->plug_started = true;
>  -      }
>  -
>  -      if (io_op_defs[req->opcode].needs_file) {
>  -              req->file = io_file_get(ctx, req, READ_ONCE(sqe->fd),
>  -                                      (sqe_flags & IOSQE_FIXED_FILE));
>  -              if (unlikely(!req->file))
>  -                      ret = -EBADF;
>  -      }
>
>  -      state->ios_left--;
>  -      return ret;
>  +      return io_req_prep(req, sqe);
>   }
>
>   static int io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,

-- 
paul moore
www.paul-moore.com
