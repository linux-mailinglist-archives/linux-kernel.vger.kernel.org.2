Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D769D316ED7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 19:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbhBJSgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 13:36:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:41086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233982AbhBJSYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 13:24:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CA1164EDC;
        Wed, 10 Feb 2021 18:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612981442;
        bh=WpLjRH5aq2e7KA6BWWKzAEWVWeMGOWJazdNJcBXWL8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yve50P3VL2WBsbAcCOUdZmxcf09zgCEEoA3bPuHxiUZXGFyKtgXTIoUkuhR3sjjVu
         vIVwJJb4S8wMO0z3lobOuXj94v4uzFwjKYLz+CkDGu5nePWOwc1rZgTN964mMB4xw7
         GdmFWyrrSXbjxttCjv/YykJfkDmA74IwN99AkXl2uGs3v/nhVJXARjQ1HeAesmYwG7
         YTiwkQF+NLuZjg2S6lNyDL6CWkK6EaKZxuFKO1zkpsUXL558bJSJtbltC/7UP1OTDH
         MBoW8JB8k4ckyoZueXQgACAg5gTMANwI3xhUjbg00yoUfUS0wHm9sMj7ct0dFduy3g
         IQ8Sm4ESYUGlA==
Date:   Wed, 10 Feb 2021 11:24:00 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Stephen Zhang <stephenzhangzsd@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        natechancellor@gmail.com, clang-built-linux@googlegroups.com,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Roeder <tmroeder@google.com>
Subject: Re: [PATCH v1] clang_tools:gen_compile_commands: Change the default
 source directory
Message-ID: <20210210182400.GA3502674@ubuntu-m3-large-x86>
References: <1612783737-3512-1-git-send-email-stephenzhangzsd@gmail.com>
 <20210208195439.GA1097868@ubuntu-m3-large-x86>
 <CALuz2=d-ENRbWgGYaO_ESEaw5eOVSwkQmkeYBJ-w0Vb3zZ+REg@mail.gmail.com>
 <20210209192729.GA820978@ubuntu-m3-large-x86>
 <CALuz2=dyA_ki98t8VNe2L1UcBXrSoJT1r6j1puEmLn7WrX87XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALuz2=dyA_ki98t8VNe2L1UcBXrSoJT1r6j1puEmLn7WrX87XQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 08:15:27PM +0800, Stephen Zhang wrote:
> Nathan Chancellor <nathan@kernel.org> 于2021年2月10日周三 上午3:27写道：
> 
> > Just as an FYI, your email was HTML, which means it won't hit LKML.
> 
> 
> Thanks for pointing that out. The existence of a GFW makes it difficult for
> me to connect
> to the mail server.  so I use git client to send patches only and reply to
> emails with
> gmail  web client.

You can configure your Gmail web client to send text responses by
default by clicking on the three dot menu in the compose window then
chose the "plain text mode" option.

> $ mkdir -p /tmp/build/perf
> >
> > $ make -C tools/perf -skj"$(nproc)" O=/tmp/build/perf
> >
> > $ cd /tmp/build/perf
> >
> > $ ~/cbl/src/linux/scripts/clang-tools/gen_compile_commands.py --log_level
> > INFO -d .
> > ...
> >
> 
> According to the code logic, the source directory is specified by
> parameters  “-d”.

Yes and no. '-d' is supposed to be the build directory but the logic of
the script clearly does not work when the build and source directories
are in completely separate tree paths. In other works:

$ make

and

$ make O=build

will work with '-d .' because the .cmd files are in '.' and the source
files will be placed relative to '.', which is correct. Your command
does not work for two reasons:

1. You are using a build directory that is not a subpath of the source
directory. In other words, this script would not work for

$ make O=/tmp/build

because '-d /tmp/build' needs to be used to find the .cmd files but then
the relative path of the source files is messed up, as you point out.

2. The source files are in tools/perf, not .

> def process_line(root_directory, command_prefix, file_path):
>     ...
>     abs_path = os.path.abspath(os.path.join(root_directory, file_path))
>     ...
> 
> The "root_directory" is passed by "-d", which finally become the prefix
> like  "/tmp/build/perf/"
> of  "File /tmp/build/perf/arch/x86/tests/bp-modify.c not found".so the
> command is:
> 
>   $ ~/cbl/src/linux/scripts/clang-tools/gen_compile_commands.py --log_level
> INFO -d  ~/cbl/src/linux/tools/perf/
> 
> Maybe we should make an updated version, in which the help message of "-d"
> can be changed
> to specify the source directory instead, or I am just misunderstanding the
> code logic.
> 

The build directory needs to be involved because that is where the .cmd
files will be but the source directory needs to be known because the
source files in the .cmd files are relative to the source directory, not
the build directory. This happens to work in most situations like I
point out above but not always.

I think that my patch is most likely the way to go unless others feel
differently. It would be nice if you could give it a go.

Cheers,
Nathan
