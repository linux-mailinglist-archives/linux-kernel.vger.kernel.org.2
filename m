Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5E5314138
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbhBHVFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:05:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:46694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236288AbhBHTzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:55:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5077E64E60;
        Mon,  8 Feb 2021 19:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612814081;
        bh=0R8RzZftEpI31ncD5g3bTaPxMjibH3lpv0jmztWi+T8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DkeFlPY0Uol8bS38yGGnZIz5GwPmNI2TXh2cQ/nJ/AqOnrtJy0nwgmZMLo59rBQDM
         IV7pzmp/vLhq0CDV1D0mkBclYOKjw+fJnabYhAf+q+JOwXQt3tYaZ7+M17zU8+Kkem
         MZEC9AKD16iiKGhQKipyltdIRf98TGTVO0S8WyCwuyemX6vRiPledLpiRy9AGIMLfh
         jlj3rDoMX6614kjg6hFuFsqnZHq9BMlxeX7uFBECeVMqhZoVwwsgljSJpdj2qbXMGH
         Bq8Vz24woF4ivAOaZfMQIG061pzo3vUfocWnCQarQJfotfYWyWWLzDFmRaoB09DW+U
         +k2kw+VrzeNzQ==
Date:   Mon, 8 Feb 2021 12:54:39 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Stephen Zhang <stephenzhangzsd@gmail.com>
Cc:     ndesaulniers@google.com, natechancellor@gmail.com,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] clang_tools:gen_compile_commands: Change the default
 source directory
Message-ID: <20210208195439.GA1097868@ubuntu-m3-large-x86>
References: <1612783737-3512-1-git-send-email-stephenzhangzsd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612783737-3512-1-git-send-email-stephenzhangzsd@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 07:28:57PM +0800, Stephen Zhang wrote:
> The default source directory is set equal to build directory which
> specified by "-d".But it is designed to be set to the current working
> directoy by default, as the help messge says.It makes a differece when
> source directory and build directory are in separted directorys.
> 
> Signed-off-by: Stephen Zhang <stephenzhangzsd@gmail.com>

I don't think this patch makes much sense unless I am misunderstanding
the description of the problem. The entire point of this script is to
parse the .cmd files that kbuild generates and those are only present
in the build directory, not the source directory, so we should never be
looking in there, unless args.directory is its default value, which is
the way the script is currently written. Your patch would appear to
either make use do way more searching than necessary (if the build
folder is within the source folder) or miss it altogether (if the build
folder is outside the source folder).

I think the help message probably needs to be updated to be a little
clearer:

diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
index 19963708bcf8..cf36d73dd3bf 100755
--- a/scripts/clang-tools/gen_compile_commands.py
+++ b/scripts/clang-tools/gen_compile_commands.py
@@ -55,7 +55,7 @@ def parse_arguments():
 
     paths_help = ('directories to search or files to parse '
                   '(files should be *.o, *.a, or modules.order). '
-                  'If nothing is specified, the current directory is searched')
+                  'If nothing is specified, the output directory is searched')
     parser.add_argument('paths', type=str, nargs='*', help=paths_help)
 
     args = parser.parse_args()

Let me know if this makes sense or if I am completely off base :)

Cheers,
Nathan

> ---
>  scripts/clang-tools/gen_compile_commands.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
> index 1996370..add9e47 100755
> --- a/scripts/clang-tools/gen_compile_commands.py
> +++ b/scripts/clang-tools/gen_compile_commands.py
> @@ -64,7 +64,7 @@ def parse_arguments():
>              os.path.abspath(args.directory),
>              args.output,
>              args.ar,
> -            args.paths if len(args.paths) > 0 else [args.directory])
> +            args.paths if len(args.paths) > 0 else [os.getcwd()])
>  
>  
>  def cmdfiles_in_dir(directory):
> -- 
> 1.8.3.1
> 
