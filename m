Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE33307F4A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 21:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhA1UNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 15:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhA1UKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 15:10:06 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C2FC061573
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 12:09:26 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id e2so5655118lfj.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 12:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pbLyXrC1k9FZUoqcNNFZRIj5HwoK9Y0SywPqi5fY9Mw=;
        b=HaMIYUKZDxCMRmzAT2hb3SOCX5nRl8mwdoT7wx7YGzBAtmRsp+fq0dZuqadOylkR4p
         VG9B0J0J1eswn3ix6AZ8wsc5wvq93+FNchubVQJJa+jprtNue/5tlRexuBi3irdxy5/Z
         Z4Vcw2NbT4GEMdHKXo/nuxJsZv+tDg1Oy2NTcSANchxmw8Tqk5sKveVJ5ebJmxnSgQNq
         Lm66GfJlWKa2jYEAUnJ1wrHngtPYafd7iGRm3NM8+Fj99WHEtilaT+rbPelc5TVFGXyA
         6V+2oka6ME+FjJNrZPtbRqPlXkCepTNe4ZzE8ApXFamrjFHGWuDI77+DcGoatDgsJkZi
         qDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pbLyXrC1k9FZUoqcNNFZRIj5HwoK9Y0SywPqi5fY9Mw=;
        b=aktHrzZxZ1CSCZDWZ+UL+Y4lGkjbUslfm+MPx92LL3E0bq1j+r0HAYGiN7ViQFgZnp
         HARuUikRQn0utBnASQQfWOO34Gv/TN/Gd6HNNDRm8LsLFXNCeZS5EEv3JPGd1lDTjKTn
         IVAZlAC5hrmFrzkRhYzpl1HAulkAdsa5voX9Rx/v6h1KuXjx5bhNOtj29nWJ4PBSHuWo
         uIcTfuDD9fd72uShvXdHh1h11hKsefz9HNWTMLu0L6QlGze7hHoroqvgIfzFBy+4r5Tp
         tP1cGt0Gs+Q4OEWOcADh86XZNtO+sEAIL8O7DZI5SBQuKhvrgs91L13cC4yQjtKsCHrV
         wDzQ==
X-Gm-Message-State: AOAM530dXDxtgLOWJW1/JQjZWe/o4CxXYWbTyu751ZXVU89iCFTlo9ib
        2Gmsdlb57vELeFYImngToLXgoZ/vopfnf4LPdGZBwYMZPtY=
X-Google-Smtp-Source: ABdhPJy/TzdQsySFsNcHg/4wk5BDS+CkS6gcNp+S9my6iG6m+Nxz2F/kNZmOGe2FmkAr/wGG2+GayBLG1kSU3GO4X5Y=
X-Received: by 2002:a19:6447:: with SMTP id b7mr349635lfj.206.1611864564446;
 Thu, 28 Jan 2021 12:09:24 -0800 (PST)
MIME-Version: 1.0
References: <20210128143802.15888-1-dwaipayanray1@gmail.com>
 <20210128143802.15888-3-dwaipayanray1@gmail.com> <1f8eb861fd74e530eeda9cb587e7cb3dc655c124.camel@perches.com>
In-Reply-To: <1f8eb861fd74e530eeda9cb587e7cb3dc655c124.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Fri, 29 Jan 2021 01:39:21 +0530
Message-ID: <CABJPP5Bd1sqNwxBcubRJte9dWSkheeABSMizO1ZKNUYw9gOEDQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] docs: add documentation for checkpatch
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 12:53 AM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2021-01-28 at 20:08 +0530, Dwaipayan Ray wrote:
> > Add documentation for kernel script checkpatch.pl.
> > This documentation is also parsed by checkpatch to
> > enable a verbose mode.
> >
> > Only a few test descriptions are added and the rest
> > will be added later over time to document all the
> > message types emitted by checkpatch.
>
> Better to document them all rather than partially.
> $ git grep -ohP '(?:\w+|\})\s*\(\s*\"[A-Z_]+"' scripts/checkpatch.pl | \
>  cut -f2 -d'"' | sort | uniq
> ALLOC_ARRAY_ARGS
> ALLOC_SIZEOF_STRUCT
> ALLOC_WITH_MULTIPLY
> ARCH_DEFINES
> ARCH_INCLUDE_LINUX
> ARRAY_SIZE
> ASSIGN_IN_IF
> ASSIGNMENT_CONTINUATIONS
> AVOID_BUG
> AVOID_EXTERNS
> AVOID_L_PREFIX
> BAD_SIGN_OFF
> BAD_STABLE_ADDRESS_STYLE
> BIT_MACRO
> BLOCK_COMMENT_STYLE
> BOOL_COMPARISON
> BRACES
> BRACKET_SPACE
> CAMELCASE
> CHECK
> CODE_INDENT
> COMMIT_COMMENT_SYMBOL
> COMMIT_LOG_LONG_LINE
> COMMIT_MESSAGE
> COMPARISON_TO_NULL
> COMPLEX_MACRO
> CONCATENATED_STRING
> CONFIG_DESCRIPTION
> CONFIG_TYPE_BOOLEAN
> CONSIDER_COMPLETION
> CONSIDER_KSTRTO
> CONSTANT_COMPARISON
> CONSTANT_CONVERSION
> CONST_CONST
> CONST_READ_MOSTLY
> CONST_STRUCT
> CORRUPTED_PATCH
> CVS_KEYWORD
> DATA_RACE
> DATE_TIME
> DEEP_INDENTATION
> DEFAULT_NO_BREAK
> DEFINE_ARCH_HAS
> DEPRECATED_API
> DEPRECATED_VARIABLE
> DEVICE_ATTR_FUNCTIONS
> DEVICE_ATTR_PERMS
> DEVICE_ATTR_RO
> DEVICE_ATTR_RW
> DEVICE_ATTR_WO
> DIFF_IN_COMMIT_MSG
> DOS_LINE_ENDINGS
> DO_WHILE_MACRO_WITH_TRAILING_SEMICOLON
> DT_SCHEMA_BINDING_PATCH
> DT_SPLIT_BINDING_PATCH
> DUPLICATED_SYSCTL_CONST
> ELSE_AFTER_BRACE
> EMAIL_SUBJECT
> EMBEDDED_FILENAME
> EMBEDDED_FUNCTION_NAME
> ENOSYS
> ENOTSUPP
> ERROR
> EXECUTE_PERMISSIONS
> EXPORTED_WORLD_WRITABLE
> EXPORT_SYMBOL
> FILE_PATH_CHANGES
> FROM_SIGN_OFF_MISMATCH
> FSF_MAILING_ADDRESS
> FUNCTION_ARGUMENTS
> FUNCTION_WITHOUT_ARGS
> GERRIT_CHANGE_ID
> GIT_COMMIT_ID
> GLOBAL_INITIALISERS
> HEXADECIMAL_BOOLEAN_TEST
> HOTPLUG_SECTION
> IN_ATOMIC
> INCLUDE_LINUX
> INDENTED_LABEL
> INIT_ATTRIBUTE
> INITIALISED_STATIC
> INLINE
> INLINE_LOCATION
> IS_ENABLED_CONFIG
> JIFFIES_COMPARISON
> KREALLOC_ARG_REUSE
> LEADING_SPACE
> LIKELY_MISUSE
> LINE_CONTINUATIONS
> LINE_SPACING
> LINUX_VERSION_CODE
> LOCKDEP
> LOCKING
> LOGGING_CONTINUATION
> LOGICAL_CONTINUATIONS
> LONG_LINE
> LONG_UDELAY
> MACRO_ARG_PRECEDENCE
> MACRO_ARG_REUSE
> MACRO_WITH_FLOW_CONTROL
> MAINTAINERS_STYLE
> MALFORMED_INCLUDE
> MASK_THEN_SHIFT
> MEMORY_BARRIER
> MEMSET
> MINMAX
> MISORDERED_TYPE
> MISPLACED_INIT
> MISSING_EOF_NEWLINE
> MISSING_SIGN_OFF
> MODIFIED_INCLUDE_ASM
> MODULE_LICENSE
> MSLEEP
> MULTILINE_DEREFERENCE
> MULTIPLE_ASSIGNMENTS
> MULTIPLE_DECLARATION
> MULTISTATEMENT_MACRO_USE_DO_WHILE
> NAKED_SSCANF
> NETWORKING_BLOCK_COMMENT_STYLE
> NEW_TYPEDEFS
> NO_AUTHOR_SIGN_OFF
> NON_OCTAL_PERMISSIONS
> NOT_UNIFIED_DIFF
> NR_CPUS
> OBSOLETE
> ONE_SEMICOLON
> OOM_MESSAGE
> OPEN_BRACE
> OPEN_ENDED_LINE
> PARENTHESIS_ALIGNMENT
> PATCH_PREFIX
> POINTER_LOCATION
> PREFER_DEFINED_ATTRIBUTE_MACRO
> PREFER_DEV_LEVEL
> PREFER_ETH_BROADCAST_ADDR
> PREFER_ETHER_ADDR_COPY
> PREFER_ETHER_ADDR_EQUAL
> PREFER_ETH_ZERO_ADDR
> PREFER_FALLTHROUGH
> PREFER_IS_ENABLED
> PREFER_KERNEL_TYPES
> PREFER_PR_LEVEL
> PREFER_SEQ_PUTS
> PRINTF_L
> PRINTF_Z
> PRINTK_RATELIMITED
> PRINTK_WITHOUT_KERN_LEVEL
> QUOTED_WHITESPACE_BEFORE_NEWLINE
> REPEATED_WORD
> RETURN_PARENTHESES
> RETURN_VOID
> SELF_ASSIGNMENT
> SINGLE_STATEMENT_DO_WHILE_MACRO
> SIZEOF_ADDRESS
> SIZEOF_PARENTHESIS
> SPACE_BEFORE_TAB
> SPACING
> SPDX_LICENSE_TAG
> SPLIT_STRING
> SSCANF_TO_KSTRTO
> STATIC_CONST
> STATIC_CONST_CHAR_ARRAY
> STORAGE_CLASS
> STRING_FRAGMENTS
> STRLCPY
> SUSPECT_CODE_INDENT
> SUSPECT_COMMA_SEMICOLON
> SWITCH_CASE_INDENT_LEVEL
> SYMBOLIC_PERMS
> TABSTOP
> TEST_ATTR
> TEST_NOT_ATTR
> TEST_NOT_TYPE
> TEST_TYPE
> TRACE_PRINTK
> TRACING_LOGGING
> TRAILING_SEMICOLON
> TRAILING_STATEMENTS
> TRAILING_WHITESPACE
> TYPECAST_INT_CONSTANT
> TYPO_SPELLING
> UAPI_INCLUDE
> UNCOMMENTED_DEFINITION
> UNDOCUMENTED_DT_STRING
> UNDOCUMENTED_SETUP
> UNKNOWN_COMMIT_ID
> UNNECESSARY_BREAK
> UNNECESSARY_CASTS
> UNNECESSARY_ELSE
> UNNECESSARY_INT
> UNNECESSARY_KERN_LEVEL
> UNNECESSARY_MODIFIER
> UNNECESSARY_PARENTHESES
> UNSPECIFIED_INT
> USE_DEVICE_INITCALL
> USE_FUNC
> USE_LOCKDEP
> USE_NEGATIVE_ERRNO
> USE_RELATIVE_PATH
> USE_SPINLOCK_T
> USLEEP_RANGE
> VOLATILE
> VSPRINTF_POINTER_EXTENSION
> VSPRINTF_SPECIFIER_PX
> WAITQUEUE_ACTIVE
> WARNING
> WEAK_DECLARATION
> WHILE_AFTER_BRACE
> WHITESPACE_AFTER_LINE_CONTINUATION
> YIELD
>

The amount looks a bit scary at a first glance!
But sure I will try to get them all documented, although it might take
a bit of time.

> > diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> []
> > +Checkpatch (scripts/checkpatch.pl) is a perl script which checks for trivial style
> > +violations in patches and optionally corrects them.  Checkpatch can also be run on
> > +file contexts and without the kernel tree.
> > +
> > +It should be noted that checkpatch may not be always right.  At times the human
>
> checkpatch is not always right.
> Your judgement takes precedence over checkpatch messages.
>
>
> > +
> > + - --types TYPE(,TYPE2...)
> > +
> > +   Only display messages with the given types.
> > +
> > +   Example::
> > +
> > +     ./scripts/checkpatch.pl mypatch.patch --types EMAIL_SUBJECT,NO_AUTHOR_SIGN_OFF
> > +
> > + - --ignore TYPE(,TYPE2...)
> > +
> > +   Strip off messages with the given types.
>
> checkpatch will not emit messages for the specified types,
>
> > +
> > +   Example::
> > +
> > +     ./scripts/checkpatch.pl mypatch.patch --ignore EMAIL_SUBJECT,NO_AUTHOR_SIGN_OFF
> > +
> > + - --show-types
> > +
> > +   By default checkpatch doesn't display the type associated with the messages.
> > +   Set this flag to show the message type in the output.
> > +
> > + - --max-line-length=n
> > +
> > +   Set the max line length (default 100).  On exceeding the given length, a message
> > +   is emitted.
>
> If a line exceeds the specified length, a LONG_LINE message is emitted.
> > +
> > +   The message level is different for patch and file contexts.  For patches, a WARNING is
> > +   emitted.  While a milder CHECK is emitted for files.  So for file contexts, the --strict
> > +   flag must also be enabled.
> > +
> > + - --min-conf-desc-length=n
> > +
> > +   Set the min description length, if shorter, warn.
>
> Kconfig entry minimum description
>

Thanks for the review Joe!

With best regards,
Dwaipayan.
