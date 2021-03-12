Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A3F338441
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 04:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbhCLDIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 22:08:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:34684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhCLDHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 22:07:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52B3064F89;
        Fri, 12 Mar 2021 03:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615518471;
        bh=RpdQQX84R3gfKDeV0Zo7C1cIJo19aHo/Ky4C3xbehOQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uTWfPUpcnDVkD0ohxuLk6q6kw590WrYrD1EKnOqDx5zSxJOQytfXgeTlbzTUwlRqk
         0JkeBIMRBXTUurysMixaUQ4myMX1ubQABrQJ9Ufm8wedWfJW6zLXSedg93pc4uJ6rZ
         Uhpg2knOJbeby2lL8CJmtxnZWV5y3ze1j7FzOlywI4nS7yzhP1KBe1Gy6vBDio0hgw
         uI1KrWYNWANOBtDz7Ews3yT4ai3F0txI5VgDVlrHV7nPg0XAEJOutS8RhW/08v92aw
         agRPFfgjYFYRIIy8aTwDSNUiTZQYzd8B493u/Qc0mlOH5r54lMGbb2e+4XEIvQtqE9
         f9MEWxCVc7+WA==
Date:   Fri, 12 Mar 2021 12:07:47 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 03/21] x86/insn: Add a __ignore_sync_check__ marker
Message-Id: <20210312120747.a321f82b61825fabaee5ea3c@kernel.org>
In-Reply-To: <20210304174237.31945-4-bp@alien8.de>
References: <20210304174237.31945-1-bp@alien8.de>
        <20210304174237.31945-4-bp@alien8.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  4 Mar 2021 18:42:19 +0100
Borislav Petkov <bp@alien8.de> wrote:

> From: Borislav Petkov <bp@suse.de>
> 
> Add an explicit __ignore_sync_check__ marker which will be used to mark
> lines which are supposed to be ignored by file synchronization check
> scripts, its advantage being that it explicitly denotes such lines in
> the code.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks,

> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/include/asm/inat.h       |  2 +-
>  arch/x86/include/asm/insn.h       |  2 +-
>  arch/x86/lib/inat.c               |  2 +-
>  arch/x86/lib/insn.c               |  6 +++---
>  tools/arch/x86/include/asm/inat.h |  2 +-
>  tools/arch/x86/include/asm/insn.h |  2 +-
>  tools/arch/x86/lib/inat.c         |  2 +-
>  tools/arch/x86/lib/insn.c         |  6 +++---
>  tools/objtool/sync-check.sh       | 17 +++++++++++++----
>  tools/perf/check-headers.sh       | 15 +++++++++++----
>  10 files changed, 36 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/include/asm/inat.h b/arch/x86/include/asm/inat.h
> index 4cf2ad521f65..b56c5741581a 100644
> --- a/arch/x86/include/asm/inat.h
> +++ b/arch/x86/include/asm/inat.h
> @@ -6,7 +6,7 @@
>   *
>   * Written by Masami Hiramatsu <mhiramat@redhat.com>
>   */
> -#include <asm/inat_types.h>
> +#include <asm/inat_types.h> /* __ignore_sync_check__ */
>  
>  /*
>   * Internal bits. Don't use bitmasks directly, because these bits are
> diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
> index 95a448fbb44c..93f84600ac2c 100644
> --- a/arch/x86/include/asm/insn.h
> +++ b/arch/x86/include/asm/insn.h
> @@ -9,7 +9,7 @@
>  
>  #include <asm/byteorder.h>
>  /* insn_attr_t is defined in inat.h */
> -#include <asm/inat.h>
> +#include <asm/inat.h> /* __ignore_sync_check__ */
>  
>  #if defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : defined(__LITTLE_ENDIAN)
>  
> diff --git a/arch/x86/lib/inat.c b/arch/x86/lib/inat.c
> index 12539fca75c4..b0f3b2a62ae2 100644
> --- a/arch/x86/lib/inat.c
> +++ b/arch/x86/lib/inat.c
> @@ -4,7 +4,7 @@
>   *
>   * Written by Masami Hiramatsu <mhiramat@redhat.com>
>   */
> -#include <asm/insn.h>
> +#include <asm/insn.h> /* __ignore_sync_check__ */
>  
>  /* Attribute tables are generated from opcode map */
>  #include "inat-tables.c"
> diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
> index 4d1640dc7882..ed1e0335aa14 100644
> --- a/arch/x86/lib/insn.c
> +++ b/arch/x86/lib/insn.c
> @@ -11,10 +11,10 @@
>  #else
>  #include <string.h>
>  #endif
> -#include <asm/inat.h>
> -#include <asm/insn.h>
> +#include <asm/inat.h> /*__ignore_sync_check__ */
> +#include <asm/insn.h> /* __ignore_sync_check__ */
>  
> -#include <asm/emulate_prefix.h>
> +#include <asm/emulate_prefix.h> /* __ignore_sync_check__ */
>  
>  #define leXX_to_cpu(t, r)						\
>  ({									\
> diff --git a/tools/arch/x86/include/asm/inat.h b/tools/arch/x86/include/asm/inat.h
> index 877827b7c2c3..a61051400311 100644
> --- a/tools/arch/x86/include/asm/inat.h
> +++ b/tools/arch/x86/include/asm/inat.h
> @@ -6,7 +6,7 @@
>   *
>   * Written by Masami Hiramatsu <mhiramat@redhat.com>
>   */
> -#include "inat_types.h"
> +#include "inat_types.h" /* __ignore_sync_check__ */
>  
>  /*
>   * Internal bits. Don't use bitmasks directly, because these bits are
> diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
> index cc777c185212..7e1239aa7dd9 100644
> --- a/tools/arch/x86/include/asm/insn.h
> +++ b/tools/arch/x86/include/asm/insn.h
> @@ -9,7 +9,7 @@
>  
>  #include <asm/byteorder.h>
>  /* insn_attr_t is defined in inat.h */
> -#include "inat.h"
> +#include "inat.h" /* __ignore_sync_check__ */
>  
>  #if defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : defined(__LITTLE_ENDIAN)
>  
> diff --git a/tools/arch/x86/lib/inat.c b/tools/arch/x86/lib/inat.c
> index 4f5ed49e1b4e..dfbcc6405941 100644
> --- a/tools/arch/x86/lib/inat.c
> +++ b/tools/arch/x86/lib/inat.c
> @@ -4,7 +4,7 @@
>   *
>   * Written by Masami Hiramatsu <mhiramat@redhat.com>
>   */
> -#include "../include/asm/insn.h"
> +#include "../include/asm/insn.h" /* __ignore_sync_check__ */
>  
>  /* Attribute tables are generated from opcode map */
>  #include "inat-tables.c"
> diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
> index 31afbf0a75f7..1174c43b3944 100644
> --- a/tools/arch/x86/lib/insn.c
> +++ b/tools/arch/x86/lib/insn.c
> @@ -11,10 +11,10 @@
>  #else
>  #include <string.h>
>  #endif
> -#include "../include/asm/inat.h"
> -#include "../include/asm/insn.h"
> +#include "../include/asm/inat.h" /* __ignore_sync_check__ */
> +#include "../include/asm/insn.h" /* __ignore_sync_check__ */
>  
> -#include "../include/asm/emulate_prefix.h"
> +#include "../include/asm/emulate_prefix.h" /* __ignore_sync_check__ */
>  
>  #define leXX_to_cpu(t, r)						\
>  ({									\
> diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
> index 606a4b5e929f..4bbabaecab14 100755
> --- a/tools/objtool/sync-check.sh
> +++ b/tools/objtool/sync-check.sh
> @@ -16,11 +16,14 @@ arch/x86/include/asm/emulate_prefix.h
>  arch/x86/lib/x86-opcode-map.txt
>  arch/x86/tools/gen-insn-attr-x86.awk
>  include/linux/static_call_types.h
> -arch/x86/include/asm/inat.h     -I '^#include [\"<]\(asm/\)*inat_types.h[\">]'
> -arch/x86/include/asm/insn.h     -I '^#include [\"<]\(asm/\)*inat.h[\">]'
> -arch/x86/lib/inat.c             -I '^#include [\"<]\(../include/\)*asm/insn.h[\">]'
> -arch/x86/lib/insn.c             -I '^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]' -I '^#include [\"<]\(../include/\)*asm/emulate_prefix.h[\">]'
>  "
> +
> +SYNC_CHECK_FILES='
> +arch/x86/include/asm/inat.h
> +arch/x86/include/asm/insn.h
> +arch/x86/lib/inat.c
> +arch/x86/lib/insn.c
> +'
>  fi
>  
>  check_2 () {
> @@ -63,3 +66,9 @@ while read -r file_entry; do
>  done <<EOF
>  $FILES
>  EOF
> +
> +if [ "$SRCARCH" = "x86" ]; then
> +	for i in $SYNC_CHECK_FILES; do
> +		check $i '-I "^.*\/\*.*__ignore_sync_check__.*\*\/.*$"'
> +	done
> +fi
> diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> index dded93a2bc89..07857dfb4d91 100755
> --- a/tools/perf/check-headers.sh
> +++ b/tools/perf/check-headers.sh
> @@ -75,6 +75,13 @@ include/uapi/asm-generic/mman-common.h
>  include/uapi/asm-generic/unistd.h
>  '
>  
> +SYNC_CHECK_FILES='
> +arch/x86/include/asm/inat.h
> +arch/x86/include/asm/insn.h
> +arch/x86/lib/inat.c
> +arch/x86/lib/insn.c
> +'
> +
>  # These copies are under tools/perf/trace/beauty/ as they are not used to in
>  # building object files only by scripts in tools/perf/trace/beauty/ to generate
>  # tables that then gets included in .c files for things like id->string syscall
> @@ -129,6 +136,10 @@ for i in $FILES; do
>    check $i -B
>  done
>  
> +for i in $SYNC_CHECK_FILES; do
> +  check $i '-I "^.*\/\*.*__ignore_sync_check__.*\*\/.*$"'
> +done
> +
>  # diff with extra ignore lines
>  check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memcpy_\(erms\|orig\))"'
>  check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memset_\(erms\|orig\))"'
> @@ -137,10 +148,6 @@ check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
>  check include/linux/build_bug.h       '-I "^#\(ifndef\|endif\)\( \/\/\)* static_assert$"'
>  check include/linux/ctype.h	      '-I "isdigit("'
>  check lib/ctype.c		      '-I "^EXPORT_SYMBOL" -I "^#include <linux/export.h>" -B'
> -check arch/x86/include/asm/inat.h     '-I "^#include [\"<]\(asm/\)*inat_types.h[\">]"'
> -check arch/x86/include/asm/insn.h     '-I "^#include [\"<]\(asm/\)*inat.h[\">]"'
> -check arch/x86/lib/inat.c	      '-I "^#include [\"<]\(../include/\)*asm/insn.h[\">]"'
> -check arch/x86/lib/insn.c             '-I "^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]" -I "^#include [\"<]\(../include/\)*asm/emulate_prefix.h[\">]"'
>  
>  # diff non-symmetric files
>  check_2 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
> -- 
> 2.29.2
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
